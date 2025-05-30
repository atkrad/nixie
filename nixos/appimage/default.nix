{
  inputs,
  pkgs,
  ...
}: {
  programs.appimage = {
    enable = true;
    binfmt = true;
    package = pkgs.appimage-run.override {
      extraPkgs = pkgs: [pkgs.fuse pkgs.fuse3];
    };
  };
}
