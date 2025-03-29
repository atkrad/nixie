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
    package = pkgs.unstable.atuin;
    settings = {
      inline_height = 25;
      show_help = false;
      show_tabs = false;
      auto_sync = false;
      style = "compact";
      workspaces = true;
      common_prefix = [
        "sudo"
        "_"
      ];
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
