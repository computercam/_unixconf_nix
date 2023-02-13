# Adapted from various sources:
# - https://alexbakker.me/post/nixos-pci-passthrough-qemu-vfio.html
# - https://codeberg.org/harrisonthorne/nixos-config
# - https://github.com/ilayna/Single-GPU-passthrough-amd-nvidia
# - https://github.com/joeknock90/Single-GPU-Passthrough
# - https://github.com/QaidVoid/Complete-Single-GPU-Passthrough
# - https://gitlab.com/Karuri/vfio/-/tree/master/
# - https://gitlab.com/risingprismtv/single-gpu-passthrough/-/tree/master
# - https://pastebin.com/q3RQZYUS
# - https://passthroughpo.st/simple-per-vm-libvirt-hooks-with-the-vfio-tools-hook-helper/
# - https://github.com/PassthroughPOST/VFIO-Tools/
# - https://github.com/basharkey/nixos-desktop/blob/main/passthrough.nix

{ config, lib, pkgs, options, ... }: {
  imports = [ ./modules.nix ];

  config = {
    # Boot configuration
    boot.kernelModules = [ 
      "kvm-amd" 
      "vfio-pci" 
    ];
    boot.kernelParams = [ 
      "iommu=pt" 
      "amd_iommu=on"
    ];
    boot.extraModprobeConfig = ''
      options kvm_amd nested=1
      options kvm ignore_msrs=1
    '';

    # VFIO Packages installed
    environment.systemPackages = with pkgs; [
      qemu # generic requirement
      virt-manager # generic requirement
      dconf # needed for saving settings in virt-manager
      libguestfs # needed to virt-sparsify qcow2 files
      pciutils # for working with pci devices
    ];

    # Enable xrdp for remote control
    services.xrdp.enable = true; # use remote_logout and remote_unlock
    systemd.services.pcscd.enable = false;
    systemd.sockets.pcscd.enable = false;

    # Power settings
    powerManagement.cpuFreqGovernor = "performance";

    # libvirtd user permissions
    users.users."${config.cfg.user.name}".extraGroups = [ "libvirtd" ];
    
    # Enable libvirtd
    virtualisation.libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";
      allowedBridges = [ "virbr0" ];
      qemu = {
        ovmf.enable = true;
        runAsRoot = true;
      };
    };

    # Add binaries to path so that hooks can use it
    systemd.services.libvirtd.path = 
      let env = pkgs.buildEnv {
        name = "qemu-hook-env";
        paths = with pkgs; [
          bash
          libvirt
          kmod
          systemd
          ripgrep
          sd
        ];
      }; in [ env ];

    # Link hooks to the correct directory
    system.activationScripts.libvirt-hooks.text =
      "ln -Tfs /etc/libvirt/hooks /var/lib/libvirt/hooks";

    environment.etc = {
      "libvirt/hooks/qemu" = {
        source = ./libvirt_hooks/qemu;
        mode = "0755";
      };

      "libvirt/hooks/kvm.sh" = {
        source = ./libvirt_hooks/kvm.sh;
        mode = "0755";
      };

      "libvirt/hooks/start.sh" = {
        source = ./libvirt_hooks/start.sh;
        mode = "0755";
      };

      "libvirt/hooks/stop.sh" = {
        source = ./libvirt_hooks/stop.sh;
        mode = "0755";
      };
    };

    # Prevent sleep on libvirt hook execution
    systemd.services."libvirt-nosleep@" = {
      unitConfig.Description = ''Preventing sleep while libvirt domain "%i" is running'';
      serviceConfig.Type = "simple";
      serviceConfig.ExecStart = ''/run/current-system/sw/bin/systemd-inhibit --what=sleep --why="Libvirt domain \"%i\" is running" --who=%U --mode=block sleep infinity'';
    };
  };
}
