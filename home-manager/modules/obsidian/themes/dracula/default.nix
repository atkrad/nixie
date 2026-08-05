{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:
stdenvNoCC.mkDerivation {
  pname = "obsidian-theme-dracula";
  version = "1.1.5";

  src = fetchFromGitHub {
    owner = "dracula";
    repo = "obsidian";
    rev = "a48370320ae150b6ac34a90305f9b781f33bec5d";
    hash = "sha256-AuKghZwcgsoMyYqjvLErmK0A10BHiXv0vLSquK5AkQ4=";
  };

  installPhase = ''
    mkdir -p $out
    cp $src/manifest.json $src/theme.css $out/
  '';

  meta = with lib; {
    homepage = "https://github.com/dracula/obsidian";
    description = "Dracula dark theme for Obsidian";
    license = licenses.mit;
  };
}
