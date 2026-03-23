{ config, pkgs, inputs, ... }:

{
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  programs.hyprland = {
    enable = true;
    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-gnome pkgs.gnome-keyring ]; # Fixes OpenURI and cursor themes in flatpaks
  };

  programs.gpu-screen-recorder.enable = true;

#  security.wrappers.gsr-kms-server = {
#    owner = "root";
#    group = "root";
#    capabilities = "cap_sys_admin+ep";
#    source = "${pkgs.gpu-screen-recorder}/bin/gsr-kms-server";
#  };
}
