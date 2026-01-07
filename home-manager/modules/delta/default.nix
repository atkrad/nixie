{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      features = "decorations mellow-barbet interactive";
      syntax-theme = "Dracula";
      line-numbers = true;
      navigate = true;
      side-by-side = true;
    };
  };
}
