# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  # cato-client = pkgs.callPackage ./cato-client { };
  plymouth-dracula-theme = pkgs.callPackage ./plymouth-dracula-theme { };
}
