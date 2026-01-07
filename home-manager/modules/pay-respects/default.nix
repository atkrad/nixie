{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.pay-respects = {
    enable = true;
  };
}
