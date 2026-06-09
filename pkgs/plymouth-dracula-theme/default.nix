{
  stdenvNoCC,
  fetchFromGitHub,
  lib,
}:
stdenvNoCC.mkDerivation {
  pname = "plymouth-dracula-theme";
  version = "0-unstable-2023-04-01";

  src = fetchFromGitHub {
    owner = "dracula";
    repo = "plymouth";
    rev = "main";
    hash = "sha256-7YwkBzkAND9lfH2ewuwna1zUkQStBBx4JHGw3/+svhA=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/plymouth/themes/dracula
    cp dracula/* $out/share/plymouth/themes/dracula
    substituteInPlace $out/share/plymouth/themes/dracula/dracula.plymouth \
      --replace-fail "/usr/" "$out/"
    runHook postInstall
  '';

  meta = {
    description = "Dark Dracula theme for Plymouth";
    homepage = "https://github.com/dracula/plymouth";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
  };
}
