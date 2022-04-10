{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.nxserver;
  nxserver = pkgs.nomachine;

  serverConf = ''
    ConfigFileVersion 4.0

    EnableDebug ${toString cfg.enableDebug}
    SessionLogLevel ${toString cfg.debugLevel}

    AvailableSessionTypes unix-remote,unix-console,unix-default,unix-application,physical-desktop,shadow

    EnablePasswordDB 0

    Section "Server"

    Name "Connection to localhost"
    Host 127.0.0.1
    Protocol NX
    Port 4000
    Authentication password

    EndSection
  '';

  nodeConf = ''
    ConfigFileVersion 4.0

    EnableDebug ${toString cfg.enableDebug}
    SessionLogLevel ${toString cfg.debugLevel}

    AvailableSessionTypes unix-remote,unix-console,unix-default,unix-application,physical-desktop,shadow

    AudioInterface pulseaudio

    EnableSmartcardSharing 1
    EnableCUPSSupport 0
    CUPSBinPath ""
    CUPSSbinPath ""
    CUPSBackendPath ""

    EnableEGLCapture 0

    DisplayServerThreads auto
    DisplayEncoderThreads auto
    EnableDirectXSupport 0
  '';
in {
  options.services.nxserver = {
    enable = mkEnableOption "the NoMachine remote desktop server";

    enableDebug = mkEnableOption "debug output";
    debugLevel = mkOption {
      default = 6;
      example = 6;
      description = "Debug output level";
      type = lib.types.int;
    };

    openFirewall = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to open port 4000 in the firewall.
      '';
    };
  };

  config = mkIf cfg.enable {
    users.users = {
      "nx" = {
        group = "nx";
        isSystemUser = true;
        shell = "${nxserver}/NX/etc/nxserver";
        home = "/var/lib/nxserver/nx";
      };
    };

    users.groups = {
      "nx" = {};
    };

    security.pam.services.nx.text = ''
      # This is a default PAM configuration for NoMachine. It is based on
      # system's 'su' configuration and can be adjusted freely according
      # to administrative needs on the system.

      auth       include       su
      account    include       su
      password   include       su
      session    include       su
    '';

    security.pam.services.nxlimits.text = ''
      # This is a default PAM configuration for NoMachine.
      # Used to obtain nx user and nxhtd user limits.

      session   optional pam_limits.so
    '';

    environment.etc = {
      "NX/server/localhost/server.cfg" = {
        text = ''ServerRoot = "${nxserver}/NX"'';
        mode = "644";
      };

      "NX/server/localhost/node.cfg" = {
        text = ''NodeRoot = "${nxserver}/NX"'';
        mode = "644";
      };

      "NX/server/localhost/client.cfg" = {
        text = ''ClientRoot = "${nxserver}/NX"'';
        mode = "644";
      };

      "NX/nxserver".source = "${nxserver}/bin/nxserver";
      "NX/nxnode".source = "${nxserver}/bin/nxnode";

      "NX/server.cfg".text = serverConf;
      "NX/node.cfg".text = nodeConf;
    };

    security.wrappers = {
      nxexec = {
        source = "${nxserver}/NX/bin/nxexec.orig";
        owner = "root";
        group = "root";
        setuid = true;
      };
    };

    networking.firewall.allowedTCPPorts = mkIf (cfg.openFirewall) [4000];

    systemd.services.nxserver = {
      description = "NoMachine Server daemon";
      wantedBy = ["multi-user.target"];
      after = ["syslog.target" "network.target" "network-online.target" "display-manager.service"];
      wants = ["network-online.target"];
      bindsTo = ["display-manager.service"];

      serviceConfig = {
        User = "nx";
        Group = "nx";

        LogsDirectory = "nxserver";

        StateDirectory = [
          "nxserver"
          "nxserver/db"
          "nxserver/db/server"
          "nxserver/nx"
        ];

        RuntimeDirectory = [
          "nxserver"
          "nxserver/run"
          "nxserver/tmp"
          "nxserver/scripts"
        ];

        ExecStartPre = let
          preStartScript = ''
            set -euo pipefail

            # always update to current version of files
            cp ${nxserver}/NX/etc.static/version /etc/NX/
            cp ${nxserver}/NX/etc.static/update.cfg /etc/NX/
            cp ${nxserver}/NX/etc.static/usb.db /etc/NX/

            # nx processes run as user "nx" need to write state and lock files to /etc/NX
            chown nx:nx /etc/NX

            # Almost all shell scripts in scripts/restriced need u+s and to be owned by root
            # Only symlinking the restricted folder does not work because of checks done by
            # nxexec (symlink is not a folder)
            cp -r ${nxserver}/NX/scripts.static/* /run/nxserver/scripts/
            for i in /run/nxserver/scripts/restricted/*.sh; do
              file=$(basename "$i")
              if [ "$file" != "nxfunct.sh" ] && [ "$file" != "nxlogrotate.sh" ]; then
                chown root:root "$i"
                chmod u+s "$i"
              fi
            done

            # nxserver can only run after the previous commands

            if [ ! -f /etc/NX/uuid ]; then
              ${nxserver}/NX/bin/nxkeygen -u > /etc/NX/uuid
            fi

            if [ ! -f /etc/NX/server.lic ]; then
              cp ${nxserver}/NX/etc.static/server.lic.sample /etc/NX/
              /etc/NX/nxserver --validate
              mv /etc/NX/server.lic.sample /etc/NX/server.lic
              chown nx:root /etc/NX/server.lic
              chmod 0400 /etc/NX/server.lic
            fi

            if [ ! -f /etc/NX/node.lic ]; then
              cp ${nxserver}/NX/etc.static/node.lic.sample /etc/NX/
              /etc/NX/nxnode --validate
              mv /etc/NX/node.lic.sample /etc/NX/node.lic
              chown nx:root /etc/NX/node.lic
              chmod 0400 /etc/NX/node.lic
              /etc/NX/nxserver --validatenode
            fi

            # This inits the database with the localhost_4000 display entry
            /etc/NX/nxserver --addtoredis

            if [ ! -f /etc/NX/keys/host/nx_host_rsa_key ]; then
              mkdir -p /etc/NX/keys/host
              ${nxserver}/NX/bin/nxkeygen -k /etc/NX/keys/host/nx_host_rsa_key -c /etc/NX/keys/host/nx_host_rsa_key.crt
              chown -R nx:root /etc/NX/keys
              chmod 0400 /etc/NX/keys/host/nx_host_rsa_key
            fi
          '';
        in "+${pkgs.writeShellScript "nxserver-prestart" preStartScript}";
        ExecStart = "${nxserver}/bin/nxserver --daemon";
        KillMode = "process";
        SuccessExitStatus = "0 SIGTERM";
        Restart = "always";
      };
    };
  };
}