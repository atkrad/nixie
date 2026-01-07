{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.ghostty = {
    enable = true;
    package = pkgs.unstable.ghostty;
    settings = {
      theme = "Dracula";
      font-size = 13;
      link-url = true;
      link-previews = true;
      window-inherit-working-directory = false;
    };
  };
}
