{ config, lib, pkgs, options, ... }:

{
  config = {
    environment.systemPackages = with pkgs; [ sshfs google-authenticator ];

    programs.gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
        enableExtraSocket = true;
      };

      dirmngr.enable = true;
    };

    programs.ssh = {
      startAgent = true;
    };

    networking.firewall.allowedTCPPorts = [ 22 ];

    services.openssh = {
      allowSFTP = true;
      ChallengeResponseAuthentication = true;
      enable = true;
      forwardX11 = false;
      logLevel = "VERBOSE";
      passwordAuthentication = true;
      permitRootLogin = "no";
      ports = [ 22 ];
      startWhenNeeded = true;

      extraConfig = ''
        AllowGroups sshusers
        ClientAliveCountMax 2
        ClientAliveInterval 15
        LoginGraceTime 1m
        PermitEmptyPasswords no
        PrintLastLog yes
        PubkeyAuthentication yes
        TCPKeepAlive yes
      '';
    };

    users.users."${cfg.username}".extraGroups = [ "sshusers" ];

    # PAM 2 FACTOR AUTH
    # Users with enabled Google Authenticator (created ~/.google_authenticator) will be required to provide Google Authenticator token to log in via sshd.
    # https://wiki.archlinux.org/index.php/Google_Authenticator
    security.pam.services.sshd.googleAuthenticator.enable = true;
  };
}
