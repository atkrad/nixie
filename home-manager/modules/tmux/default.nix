{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    xsel
    pstree # Recommended for "tmux-fzf" plugin
  ];

  programs.tmux = {
    enable = true;
    shortcut = "a";
    clock24 = true;
    baseIndex = 1;
    historyLimit = 10000;
    plugins = with pkgs.tmuxPlugins; [
      copycat
      pain-control
      better-mouse-mode
      {
        plugin = tmux-fzf;
        extraConfig = ''
          TMUX_FZF_LAUNCH_KEY="C-f"
        '';
      }
      {
        plugin = yank;
        extraConfig = ''
          set -g @override_copy_command '${pkgs.xsel}/bin/xsel'
          set -g @yank_action 'copy-pipe-and-cancel'
        '';
      }
      {
        plugin = dracula;
        extraConfig = ''
          set -g @dracula-show-left-icon session
          set -g @dracula-show-flags true
          set -g @dracula-show-powerline true
          set -g @dracula-refresh-rate 2
          set -g @dracula-military-time true
          set -g @dracula-plugins "time"
        '';
      }
    ];
    extraConfig = ''
      # Keybinding.
      bind -n C-PageUp   previous-window
      bind -n C-PageDown next-window

      set-option -g default-terminal screen-256color
      set-option -ga terminal-overrides ',xterm-256color:Tc'

      # Terminal window names
      set-option -g set-titles on
      set-option -g set-titles-string '#{window_name}'

      # Clipboard integration
      set-option -g set-clipboard on

      # Mouse behaviour
      set-option -g mouse on

      # window: renumber
      set-option -g renumber-windows on
    '';
  };
}
