{ config, lib, pkgs, options, ... }: {
  config = {
    environment.systemPackages = with pkgs; [
        python3Full
        python39Packages.pandas
        python39Packages.numpy
        python39Packages.seaborn
        python39Packages.matplotlib
        python39Packages.xgboost
        python39Packages.ipykernel
    ];
  };
}
