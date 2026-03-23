{ inputs, lib, config, pkgs, extensions, ... }:
{
  home.packages = with pkgs; [
    hyprpicker
    waybar

    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww

    zenity
  ];
  
  programs.swaylock.enable = true;

 # theme
   home.pointerCursor = {
     gtk.enable = true;
     x11.enable = true;
     name = "macOS";
     size = 24;
     package = pkgs.apple-cursor;
   };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.magnetic-catppuccin-gtk;
      name = "catppuccin";
    };

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "papirus";
    };

    cursorTheme = {
      name = "macOS";
      package = pkgs.apple-cursor;
    };
    gtk3.extraConfig = {
      "gtk-cursor-theme-name" = "macOS";
    };
    gtk4.extraConfig = {
      Settings = ''
      gtk-cursor-theme-name=macOS
      '';
    };

    font = {
      name = "JetbrainsMono NFM Medium";
      size = 11;
    };
  };

 }
