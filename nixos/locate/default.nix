{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  services.locate = {
    enable = true;
    package = pkgs.mlocate;
    interval = "hourly";
  };
}
