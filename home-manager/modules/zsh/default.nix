{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableVteIntegration = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    history = {
      extended = true;
      ignorePatterns = [
        "rm *"
        "pkill *"
        "reboot"
        "shutdown"
        "shutdown *"
      ];
    };
    plugins = with pkgs; [
      {
        name = "fzf-tab";
        src = zsh-fzf-tab.src;
      }
    ];
    oh-my-zsh = {
      enable = true;
      plugins = [
        "cp"
        "git"
        "sudo"
        "systemd"
        "history-substring-search"
        "helm"
        "docker"
        "aws"
        "terraform"
        "ansible"
        "kubectl"
        "kubectx"
        "golang"
      ];
    };
  };
}
