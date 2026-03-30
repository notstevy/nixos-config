{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";
  };

  outputs = { self, nixpkgs }: let
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
#    default-unwrapped = pkgs.callPackage ./default-fuckit.nix {};
    default-unwrapped = pkgs.callPackage ./default-unwrapped.nix {};
  in {
    defaultPackage.x86_64-linux = pkgs.callPackage ./default.nix { inherit default-unwrapped; };
  };
}
