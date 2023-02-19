{ config, lib, pkgs, options, ... }: 
  let 
    # osx-kvm = fetchFromGithub {
    #     owner = "kholia";
    #     repo = "OSX-KVM";
    #     rev = "1184c09";
    #     sha256 = "";
    # };
    #
    # fetchMacOS = pkgs.stdenv.mkDerivation {
    #   name = "fetchMacOS";
    #   buildInputs = [
    #     (pkgs.python38.withPackages (pyPkgs: with pyPkgs; [ requests click ]))
    #   ];
    #   unpackPhase = "true";
    #   installPhase = ''
    #     mkdir -p $out/bin
    #     cp ${osx-kvm}/tools/FetchMacOS/fetch-macos.py $out/bin/fetchMacOS
    #     chmod +x $out/bin/fetchMacOS
    #   '';
    # };
  in
{
  config = {
    boot.initrd.availableKernelModules = [ "amdgpu" ];

    cfg.vfio.passthrough.gpu_video = "pci_0000_03_00_0";
    cfg.vfio.passthrough.gpu_audio = "pci_0000_03_00_1";

    # boot.blacklistedKernelModules = [
    # "amdgpu"
    # "radeon"
    # ];

  };
}
