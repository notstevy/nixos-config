{
  description = "NixOS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";
    #nixos-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager?ref=release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";      
    };
    hytale-launcher = {
      url = "github:TNAZEP/HytaleLauncherFlake";  
      inputs.nixpkgs.follows = "nixpkgs";      
    };
    awww = {
      url = "git+https://codeberg.org/LGFae/awww";
      inputs.nixpkgs.follows = "nixpkgs";      
    };
    nix4vscode = {
      url = "github:nix-community/nix4vscode";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dolphin-overlay = {
      url = "github:rumboon/dolphin-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helium = {
      url = "github:schembriaiden/helium-browser-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nix4vscode, dolphin-overlay, hyprland, caelestia-shell, ... }@inputs: # nixos-unstable
    let pkgs = import nixpkgs {
        config.allowUnfree = true;
        system = "x86_64-linux"; # One of supported systems
        overlays = [
          nix4vscode.overlays.default
        ];
      };

    #pkgs-unstable = import nixos-unstable {
    #    config.allowUnfree = true;
    #    system = "x86_64-linux"; # One of supported systems
    #};
      
      extensions = pkgs.nix4vscode.forVscode [
        "tamasfe.even-better-toml"
        "ms-vscode-remote.remote-containers"
        "editorconfig.editorconfig"
        "spgoding.datapack-language-server"
        "jasew.vscode-helix-emulation"
        "blueglassblock.better-json5"
      ] ++ pkgs.nix4vscode.forOpenVsx [
        "jeanp413.open-remote-ssh"
        "astro-build.astro-vscode"
        "Vue.volar"
        "picomet.alpinejs"
      ];
    in
    {
      nixosConfigurations.npc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; }; # pkgs-unstable
        modules = [
           {
            nixpkgs.config.allowUnfree = true;
            nixpkgs.config.android_sdk.accept_license = true;
            nixpkgs.overlays = [
              dolphin-overlay.overlays.default
              (final: prev: {
                hyprcap = prev.callPackage ./overlays/hyprcap/default.nix {};
              })
            ];
          }
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.notstevy = ./home.nix;
              home-manager.extraSpecialArgs = { inherit inputs extensions; };
           }
        ];
      };

      homeConfigurations."notstevy@npc" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        modules = [
          {
            wayland.windowManager.hyprland = {
              enable = true;
              # set the flake package
              package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
              portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
            };
          }
        ];
      };
   };
}
