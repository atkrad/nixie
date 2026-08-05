{
  lib,
  stdenvNoCC,
  fetchurl,
}:
let
  version = "0.23.2";
  repo = "https://github.com/tgrosinger/advanced-tables-obsidian";
in
stdenvNoCC.mkDerivation {
  pname = "obsidian-plugin-advanced-tables";
  inherit version;

  mainJs = fetchurl {
    url = "${repo}/releases/download/${version}/main.js";
    hash = "sha256-z13U3b3evvaMyZzZOog+M4lcfxI9BLxdEQbqbjOLp5E=";
  };

  manifest = fetchurl {
    url = "${repo}/releases/download/${version}/manifest.json";
    hash = "sha256-aYtPd0ReB9iH8zRQ6vUzoo4Jm3tIP2QvqIM2L/vY/+k=";
  };

  stylesCss = fetchurl {
    url = "${repo}/releases/download/${version}/styles.css";
    hash = "sha256-I/ow128Rf9PRYkxMLm3e2r+AmSOZawU0iV+CVOpqOfc=";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out
    cp $mainJs $out/main.js
    cp $manifest $out/manifest.json
    cp $stylesCss $out/styles.css
  '';

  meta = with lib; {
    homepage = repo;
    description = "Improved table navigation, formatting, manipulation, and formulas";
    license = licenses.gpl3Only;
  };
}
