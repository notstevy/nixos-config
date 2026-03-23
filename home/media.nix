{ inputs, lib, config, pkgs, extensions, ... }:
{
  home.packages = with pkgs; [    
    qimgv
    mpv
    vlc

    inkscape
    gimp

    blender

    obs-studio
    kdePackages.kdenlive

    ffmpeg

    scrcpy
  ];

}
