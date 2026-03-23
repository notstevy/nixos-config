{ inputs, lib, config, pkgs, extensions, ... }:
{
  imports = [
    inputs.caelestia-shell.homeManagerModules.default
  ];
  
  home.packages = with pkgs; [
    inputs.hyprcap.packages.${pkgs.stdenv.hostPlatform.system}.default
    gpu-screen-recorder-gtk # GUI app

    # screenshot
    grim
    slurp
  ];

  home.sessionVariables = {
    WEBKIT_DISABLE_DMABUF_RENDERER = "1";
    GSK_RENDERER = "gl";
  };
  
  programs.caelestia = {
    enable = true;
    
    systemd = {
      enable = false; # if you prefer starting from your compositor
      target = "graphical-session.target";
      environment = [];
    };
    
    settings = {
      appearance = {
        font.family = {
          mono = "JetBrainsMonoNL Nerd Font Mono";
        };

        anim = {
          durations.scale = 0.33;        
        };

        transparency = {
          enabled = true;
          base = 0.85;
          layers = 0.4;
        };
      };

      general = {
        apps = {
          terminal = ["kitty"];
          audio = ["pavucontrol"];
          playback = ["mpv"];
          explorer = ["dolphin"];
        };
      };

      background = {
        enabled = true;
        desktopClock = {
          enabled = true;
        };
      };

      bar = {
        status = {
          showAudio = true;
          showMicrophone = true;
          showNetwork = false;
          showWifi = false;
          showBluetooth = false;
          showBattery = false;
          showLockStatus = true;
        };
      };
      
      paths.wallpaperDir = "~/Pictures";
    };
    
    cli = {
      enable = true; # Also add caelestia-cli to path
      settings = {
        theme.enableGtk = false;
      };
    };
  };
  
  wayland.windowManager.hyprland.plugins = [
    #inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprbars
  ];
}
