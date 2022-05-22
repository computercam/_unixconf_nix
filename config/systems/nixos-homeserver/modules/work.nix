{ config, lib, pkgs, options, ... }: {
  config = {
    environment.systemPackages = with pkgs; [
      slack
      teams
      haproxy
      mkcert
    ];

    nix.allowedUsers = [ "work" ];

    users.groups.work.name = "work";
    users.users.work = {
      extraGroups = [ "sshusers" "docker" ];
      group = config.users.groups.work.name;
      home = "/Volumes/Storage/Work";
      initialPassword = "work";
      isNormalUser = true;
      name = "work";
      shell = pkgs.zsh;
      packages = with pkgs; [
          nodejs-slim-10_x
          nodejs-10_x
          maven
      ];
    };

    home-manager.users.work = {
      home.packages = config
        .home-manager
        .users
        ."${config.cfg.user.name}"
        .home
        .packages;

      programs.zsh = {
        enable = true;

        initExtra = config
          .home-manager
          .users
          ."${config.cfg.user.name}"
          .programs
          .zsh
          .initExtra;
      };
    };

    programs.java = {
      enable = true;
      package = with pkgs; jdk11;
    };

    nixpkgs.config.permittedInsecurePackages = [
      "nodejs-10.24.1"
      "nodejs-slim-10.24.1"
      "electron-13.6.9"
      "electron-14.2.9"
    ];

    networking.firewall.allowedTCPPorts = [ 
      4502 
      4503 
      80 
      443
    ];
    
    networking.hosts = { 
      "127.0.0.1" = [ 
        "devixd-aem.toyota.com"
        "devixd-aem-ssl.toyota.com"
        "devixd-aem-author-ssl.toyota.com"
      ]; 
    };

    services.haproxy = {
      user = "root";
      group = "root";
      enable = true;
      config = ''
      global
          log         127.0.0.1 local2
          pidfile   /var/run/haproxy/haproxy.pid
          maxconn     4000
          daemon
      
      defaults
          mode                    http
          log                     global
          option                  httplog
          option                  dontlognull
          option  http-server-close
          option  forwardfor      except 127.0.0.0/8
          retries                 3
          timeout http-request    10s
          timeout queue           1m
          timeout connect         10s
          timeout client          1m
          timeout server          1m
          timeout http-keep-alive 10s
          timeout check           10s
          maxconn                 3000
      
      frontend  http-in
          bind *:443 ssl force-tlsv12 crt ${ /. + ./devixd-aem.toyota.com-bundle.pem }

          acl host_aem               hdr(host)    -i devixd-aem.toyota.com
          acl host_aem-ssl           hdr(host)    -i devixd-aem-ssl.toyota.com
          acl host_aem-ssl-author    hdr(host)    -i devixd-aem-author-ssl.toyota.com

          use_backend backend_aem                 if host_aem
          use_backend backend_aem-ssl             if host_aem-ssl
          use_backend backend_aem-ssl-author      if host_aem-ssl-author

          acl host_rem_aem               hdr(host)    -i devixd-aem.toyota.com
          acl host_rem_aem-ssl           hdr(host)    -i devixd-aem-ssl.toyota.com
          acl host_rem_aem-ssl-author    hdr(host)    -i devixd-aem-author-ssl.toyota.com

          use_backend backend_rem_aem                 if host_aem
          use_backend backend_rem_aem-ssl             if host_aem-ssl
          use_backend backend_rem_aem-ssl-author      if host_aem-ssl-author
      
      backend backend_aem
          balance     roundrobin
          server      server_aem                  127.0.0.1:80 check
          http-request set-header X-Forwarded-Port %[dst_port]
          http-request add-header X-Forwarded-Proto https if { ssl_fc }

      backend backend_aem-ssl
          balance     roundrobin
          server      server_aem-ssl              127.0.0.1:80 check
          http-request set-header X-Forwarded-Port %[dst_port]
          http-request add-header X-Forwarded-Proto https if { ssl_fc }
      
      backend backend_aem-ssl-author
          balance     roundrobin
          server      server_aem-ssl-author       127.0.0.1:4502 check
          http-request set-header X-Forwarded-Port %[dst_port]
          http-request add-header X-Forwarded-Proto https if { ssl_fc }
      
      backend backend_rem_aem
          balance     roundrobin
          server      server_rem_aem              ${config.cfg.networking.static.ip_address}:80 check
          http-request set-header X-Forwarded-Port %[dst_port]
          http-request add-header X-Forwarded-Proto https if { ssl_fc }

      backend backend_rem_aem-ssl
          balance     roundrobin
          server      server_rem_aem-ssl          ${config.cfg.networking.static.ip_address}:80 check
          http-request set-header X-Forwarded-Port %[dst_port]
          http-request add-header X-Forwarded-Proto https if { ssl_fc }
      
      backend backend_rem_aem-ssl-author
          balance     roundrobin
          server      server_rem_aem-ssl-author   ${config.cfg.networking.static.ip_address}:4502 check
          http-request set-header X-Forwarded-Port %[dst_port]
          http-request add-header X-Forwarded-Proto https if { ssl_fc }
      '';
    };
  };
}
