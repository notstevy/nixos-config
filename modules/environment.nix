{ inputs, lib, config, pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default

    kdePackages.dolphin
    kdePackages.dolphin-plugins
    kdePackages.konsole # required for dolphin's built-in konsole
    kdePackages.ark
    kdePackages.kio
    kdePackages.kdf
    kdePackages.kio-fuse
    kdePackages.kio-extras
    kdePackages.kio-admin
    kdePackages.qtwayland
    kdePackages.plasma-integration
    kdePackages.kdegraphics-thumbnailers
    kdePackages.qtsvg #https://www.reddit.com/r/hyprland/comments/18ecoo3/dolphin_doesnt_work_properly_in_nixos_hyprland/
    kdePackages.kservice
    kdePackages.polkit-kde-agent-1
    kdePackages.ffmpegthumbs
    kdePackages.kimageformats
    shared-mime-info

    qt6.qtbase
    qt6.wrapQtAppsHook
    libsForQt5.qt5.qtwayland

    corefonts

    pavucontrol

    swaynotificationcenter
    libnotify
    
    wl-clipboard

    libsecret
    gnome-keyring

    gammastep
  ];

  services.gnome.gnome-keyring.enable = true;
  services.gnome.glib-networking.enable = true;
  
  programs.xwayland.enable = true;
  programs.regreet.enable = true;
  programs.dconf.enable = true;


}
