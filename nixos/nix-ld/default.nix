{
  inputs,
  pkgs,
  ...
}: {
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
    zlib
    libgcc
    stdenv.cc.cc
  ];

  environment.systemPackages = with pkgs; [
    inputs.nix-alien.packages."x86_64-linux".nix-alien
  ];
}
