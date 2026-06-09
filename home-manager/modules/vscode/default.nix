{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };
}
