{ config, pkgs, inputs, ...  }:

{
  programs.niri.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-gnome pkgs.gnome-keyring ]; # Fixes OpenURI and cursor themes in flatpaks
  };
}
