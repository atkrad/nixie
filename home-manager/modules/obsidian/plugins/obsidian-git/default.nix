{
  lib,
  stdenvNoCC,
  fetchurl,
}:
let
  version = "2.38.6";
  repo = "https://github.com/Vinzent03/obsidian-git";
in
stdenvNoCC.mkDerivation {
  pname = "obsidian-plugin-git";
  inherit version;

  mainJs = fetchurl {
    url = "${repo}/releases/download/${version}/main.js";
    hash = "sha256-Ma2J09lzy1UgZH1Sf1DYwj/NQhdnaDYXQaVDr1bVYoc=";
  };

  manifest = fetchurl {
    url = "${repo}/releases/download/${version}/manifest.json";
    hash = "sha256-Zzke+oQJPVYBH0N2T/TxyEbditUrHx39AQq2KLIXwqM=";
  };

  stylesCss = fetchurl {
    url = "${repo}/releases/download/${version}/styles.css";
    hash = "sha256-9auT9NW03RvR5XeGTFx5CH9639RIrDRuBInlhHzmki0=";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out
    cp $mainJs $out/main.js
    cp $manifest $out/manifest.json
    cp $stylesCss $out/styles.css
  '';

  passthru.manifestId = "obsidian-git";

  meta = with lib; {
    homepage = repo;
    description = "Git version control with automatic commit-and-sync for Obsidian";
    license = licenses.mit;
  };
}
