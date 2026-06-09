{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "dracula";
      theme_background = true;
      update_ms = 1000;
    };
  };
}
