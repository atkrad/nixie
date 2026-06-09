{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    most
  ];

  home.sessionVariables = {
    MANPAGER = "most";
  };
}
