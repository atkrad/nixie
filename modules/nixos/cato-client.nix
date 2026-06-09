{
  lib,
  pkgs,
  config,
  ...
}:
let
  # Shorter name to access final settings a
  # user of cato-client.nix module HAS ACTUALLY SET.
  cfg = config.services.cato-client;
in
{
  # Declare what settings a user of this "cato-client.nix" module CAN SET.
  options.services.cato-client = {
    enable = lib.mkEnableOption "Cato VPN Client";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.cato-client;
      defaultText = lib.literalExpression "pkgs.cato-client";
      example = lib.literalExpression "pkgs.cato-client";
    };
  };

  # Define what other settings, services and resources should be active IF
  # a user of this "hello.nix" module ENABLED this module
  # by setting "services.hello.enable = true;".
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    systemd = {
      packages = [ cfg.package ];
      services.cato-client = {
        wantedBy = [ "multi-user.target" ];
      };
    };
  };
}
