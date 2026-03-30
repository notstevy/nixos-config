{ inputs, lib, config, pkgs, extensions, ... }:
{
  home.packages = with pkgs; [
    prismlauncher
    inputs.hytale-launcher.packages.${pkgs.stdenv.hostPlatform.system}.default

#    inputs.noriskclient-pr.noriskclient-launcher
    noriskclient-launcher
        
    blockbench
  ];

}
