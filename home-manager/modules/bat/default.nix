{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  programs.bat = {
    enable = true;
    config = {
      theme = "Dracula";
    };
  };
}
