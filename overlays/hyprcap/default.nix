{
  lib,
  stdenv,
  fetchFromGitHub,
  hyprland,
  jq,
  slurp,
  grim,
  wf-recorder,
  wl-clipboard,
  hyprpicker,
  fuzzel,
  libnotify,
  makeWrapper
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hyprcap";
  version = "1.5.1";

  src = fetchFromGitHub {
    owner = "alonso-herreros";
    repo = "hyprcap";
    tag = "v${finalAttrs.version}";
    hash = "sha256-qTlv4hRy9CvB+ZkNxXuxtLjDHsjiyjjooUlDFxwqQOc=";
  };

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    install -Dm755 hyprcap $out/bin/hyprcap

    wrapProgram $out/bin/hyprcap \
      --prefix PATH : ${lib.makeBinPath [ hyprland wf-recorder grim slurp jq wl-clipboard hyprpicker fuzzel libnotify ]}

    runHook postInstall
  '';

  meta = {
    description = "HyprCap is a utility to easily capture screenshots and screen recordings on Hyprland";
    homepage = "https://github.com/alonso-herreros/hyprcap";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "hyprcap";
    platforms = lib.platforms.all;
  };
})
