{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  programs.gnupg = {
    agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
