{ config, lib, pkgs, options, ... }:

with lib; {
  config = {
    environment.systemPackages = with pkgs; [ samba ];
    services.samba = {
      enable = true;
      syncPasswordsByPam = true;
      shares = {
        public = {
          path = "/srv/sharedfolders/Cameron/Public";
          browseable = "yes";
          printable = "no";
          "inherit acls" = "yes";
          "inherit permissions" = "yes";
          "guest ok" = "no";
          "guest only" = "no";
          "read only" = "no";
          "store dos attributes" = "no";
          "create mask" = "0664";
          "force create mode" = "0664";
          "directory mask" = "0775";
          "force directory mode" = "0775";
          "hide special files" = "no";
          "follow symlinks" = "yes";
          "hide dot files" = "no";
          "valid users" = ''"cameron",@"cameron","filesshared",@"filesshared"'';
          "write list" = ''"cameron",@"cameron"'';
        };

        cameron = {
          path = "/srv/sharedfolders/Cameron";
          browseable = "yes";
          printable = "no";
          "inherit acls" = "yes";
          "inherit permissions" = "yes";
          "guest ok" = "no";
          "guest only" = "no";
          "read only" = "no";
          "store dos attributes" = "no";
          "create mask" = "0664";
          "force create mode" = "0664";
          "directory mask" = "0775";
          "force directory mode" = "0775";
          "hide special files" = "no";
          "follow symlinks" = "yes";
          "hide dot files" = "no";
          "valid users" = ''"cameron",@"cameron","filesfull",@"filesfull"'';
          "write list" = ''"cameron",@"cameron"'';
        };

        rae = {
          path = "/srv/sharedfolders/Cameron/Rae";
          browseable = "yes";
          printable = "no";
          "inherit acls" = "yes";
          "inherit permissions" = "yes";
          "guest ok" = "no";
          "guest only" = "no";
          "read only" = "no";
          "store dos attributes" = "no";
          "create mask" = "0664";
          "force create mode" = "0664";
          "directory mask" = "0775";
          "force directory mode" = "0775";
          "hide special files" = "no";
          "follow symlinks" = "yes";
          "hide dot files" = "no";
          "valid users" = ''"cameron",@"cameron","rae",@"rae"'';
          "write list" = ''"cameron",@"cameron"'';
        };
      };
    };
  };
}
