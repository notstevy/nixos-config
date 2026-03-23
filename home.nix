{ inputs, lib, config, pkgs, extensions,...}:
{
  imports = [
    ./home/theme.nix
    ./home/media.nix
    ./home/zsh.nix
    ./home/games.nix
    ./home/hyprland.nix
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "25.11"; 

  home = {
    username = "notstevy";
    homeDirectory = "/home/notstevy";
    sessionPath = [
      "/home/notstevy/.cargo/bin"
    ];
  };

  home.packages = with pkgs; [
    # Socials
    vesktop
    teamspeak6-client

    # Text Editors
    onlyoffice-desktopeditors
    obsidian
    inputs.helix.packages.${pkgs.stdenv.hostPlatform.system}.default
    #jetbrains-toolbox
    (pkgs.runCommand "jetbrains-toolbox-wrapped" {
      buildInputs = [ pkgs.makeWrapper ];
    } ''
      mkdir -p $out/bin
      makeWrapper ${pkgs.jetbrains-toolbox}/bin/jetbrains-toolbox $out/bin/jetbrains-toolbox \
        --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath [ pkgs.libsecret pkgs.glib ]}"
    '')

    # Development: Web
    yarn
    nodejs
    bun
    tailwindcss
    pnpm

    # Development: Android
    apktool
    android-tools
    (pkgs.androidenv.composeAndroidPackages {
      buildToolsVersions = [ "34.0.0" "33.0.1" ];
      platformVersions = [ "34" "33" ];
    }).androidsdk

    # Development: Rust, C
    cmake
    gcc
    gnumake
    rustup
    llvmPackages.lldb
    pkg-config

    # Development: PHP
    php
    php.packages.composer
 
    # Development: Raspberry Pi Pico    
    pico-sdk
    picotool
    devenv
    
    openjfx
    xwayland-satellite
  ];

  # Development
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
    ] ++ extensions;
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "notstevy";
        email = "notstevy@ultrabuildmc.de";
      };
    };
  };

  # Development: Java
  programs.java = {
    enable = true;
    #package = (pkgs.jdk25.override { enableJavaFX = true; });
    package = pkgs.jdk25;
  };

}
