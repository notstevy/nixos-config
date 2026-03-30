{ lib, fetchFromGitHub, fetchYarnDeps, noriskclient-launcher-unwrapped }:

noriskclient-launcher-unwrapped.overrideAttrs (oldAttrs: 
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
    cargoRoot = "src-tauri";  # explicitly keep this
    buildAndTestSubdir = "src-tauri";  # and this
    cargoHash = "";
    checkFlags = [
      # test fails to find correct function
      "--skip=utils::string_utils::safe_truncate"
    ];
  }
)
