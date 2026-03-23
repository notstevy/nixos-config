{ inputs, lib, config, pkgs, extensions, ... }:
{
  home.packages = with pkgs; [
    prismlauncher
    inputs.hytale-launcher.packages.${pkgs.stdenv.hostPlatform.system}.default

    (noriskclient-launcher.overrideAttrs (oldAttrs: 
      let
        version = "0.6.19";
        src = fetchFromGitHub {
          owner = "NoRiskClient";
          repo = "noriskclient-launcher";
          tag = "v${version}";
          hash = "sha256-SHLYCpflIjslCuCPROyuVsIdNIkHWl2BVflgxAz3RYg=";
        };
      in {
        inherit version src;
        yarnOfflineCache = fetchYarnDeps {
          yarnLock = "${src}/yarn.lock";
          hash = "sha256-tRvtYeOUn3xm7dhLWnzlpS8SK8NVVQAtNgvyiM48X28=";
        };
      }
    ))

    blockbench
  ];

}
