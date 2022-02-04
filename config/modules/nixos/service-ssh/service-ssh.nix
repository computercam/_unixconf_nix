{ config, lib, pkgs, options, ... }: {
  config = {
    users.users.main.extraGroups = [ "sshusers" ];

    programs.gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
        enableExtraSocket = true;
      };

      dirmngr.enable = true;
    };

    ## gnupg agent and ssh agent can't be enabled at the same time
    # programs.ssh.startAgent = true;

    networking.firewall.allowedTCPPorts = [ 22 ];

    services.openssh = {
      allowSFTP = true;
      challengeResponseAuthentication = true;
      enable = true;
      forwardX11 = false;
      logLevel = "VERBOSE";
      passwordAuthentication = true;
      permitRootLogin = "no";
      ports = [ 22 ];
      startWhenNeeded = true;

      # TODO: consider remove uneeded options here
      # TODO: consider making these values configurable
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

    # # PAM 2 FACTOR AUTH
    # # Users with enabled Google Authenticator (created ~/.google_authenticator) will be required to provide Google Authenticator token to log in via sshd.
    # # https://wiki.archlinux.org/index.php/Google_Authenticator
    # security.pam.services.sshd.googleAuthenticator.enable = true;
  };
}
