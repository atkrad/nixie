{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.atuin = {
    flags = ["--disable-up-arrow"];
    enable = true;
    settings = {
      auto_sync = false;
      style = "compact";
      theme.name = "marine";
      common_subcommands = [
        "composer"
        "docker"
        "git"
        "go"
        "kubectl"
        "helm"
        "nix"
        "npm"
        "podman"
        "systemctl"
        "tmux"
      ];
    };
  };
}
