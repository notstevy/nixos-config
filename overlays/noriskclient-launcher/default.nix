{
  addDriverRunpath,
  alsa-lib,
  flite,
  glib,
  glib-networking,
  gsettings-desktop-schemas,
  jdk17,
  jdk21,
  jdk8,
  jdks ? [
    jdk8
    jdk17
    jdk21
  ],
  lib,
  libGL,
  libjack2,
  libpulseaudio,
  libX11,
  libXcursor,
  libXext,
  libXrandr,
  libXxf86vm,
  pipewire,
  stdenv,
  symlinkJoin,
  default-unwrapped,
  udev,
  wrapGAppsHook4,
}:

symlinkJoin {
  pname = "noriskclient-launcher";
  
  inherit (default-unwrapped) version;

  paths = [ default-unwrapped ];

  strictDeps = true;

  nativeBuildInputs = [
    glib
    wrapGAppsHook4
  ];

  buildInputs = [
    glib-networking
    gsettings-desktop-schemas
  ];

  runtimeDependencies = lib.optionalString stdenv.hostPlatform.isLinux (
    lib.makeLibraryPath [
      addDriverRunpath.driverLink

      # glfw
      libGL
      libX11
      libXcursor
      libXext
      libXrandr
      libXxf86vm

      # narrator support
      flite

      # openal
      alsa-lib
      libjack2
      libpulseaudio
      pipewire

      # oshi
      udev
    ]
  );

  postBuild = ''
    gappsWrapperArgs+=(
      --prefix PATH : ${lib.makeSearchPath "bin/java" jdks}
      ${lib.optionalString stdenv.hostPlatform.isLinux ''
        --set LD_LIBRARY_PATH $runtimeDependencies
      ''}
    )

    glibPostInstallHook
    gappsWrapperArgsHook
    wrapGAppsHook
  '';

  meta = {
    inherit (default-unwrapped.meta)
      description
      homepage
      license
      longDescription
      maintainers
      mainProgram
      platforms
      ;
  };
}

