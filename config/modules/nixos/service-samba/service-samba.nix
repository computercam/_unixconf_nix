{ config, lib, pkgs, options, ... }:
{
  imports = [
    ../service-avahi/service-avahi.nix
  ];

  config = {
    environment.systemPackages = with pkgs; [ cifs-utils ];
    
    services.samba = {
      enable = true;
      openFirewall = true;
      syncPasswordsByPam = true;

      extraConfig = ''
        aio read size = 16384
        aio write size = 16384
        allow insecure wide links = yes
        browseable = yes
        case sensitive = yes
        default case = lower
        follow symlinks = yes
        guest ok = no
        guest only = no
        hide dot files = yes
        hide special files = yes
        inherit permissions = yes
        log level = 2
        logging = syslog
        max log size = 1000
        multicast dns register = yes
        preserve case = yes
        read only = no
        server role = standalone server
        server string = ${config.networking.hostName} Samba Server
        short preserve case = yes
        socket options = TCP_NODELAY IPTOS_LOWDELAY
        store dos attributes = yes
        unix extensions = yes
        use sendfile = yes
        wide links = yes
        write list = ${cfg.username}
        
        # # OSX Specific Configurations
        # min protocol = SMB2
        # vfs objects = catia fruit streams_xattr
        # fruit:delete_empty_adfiles = yes
        # fruit:metadata = stream
        # fruit:model = MacSamba
        # fruit:posix_rename = yes
        # fruit:veto_appledouble = no
        # fruit:wipe_intentionally_left_blank_rfork = yes
      '';
    };
    
    # services.avahi = {
    #   extraServiceFiles = {
    #     smb = ''
    #       <?xml version="1.0" standalone='no'?><!--*-nxml-*-->
    #       <!DOCTYPE service-group SYSTEM "avahi-service.dtd">
    #       <service-group>
    #         <name replace-wildcards="yes">%h</name>
    #         <service>
    #           <type>_smb._tcp</type>
    #           <port>445</port>
    #         </service>
    #       </service-group>
    #     '';
    #   };
    # };
  };
}