{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  programs.ghostty = {
    enable = true;
    package = pkgs.unstable.ghostty;
    settings = {
      theme = "Dracula";
      font-size = 12;
      font-family = "JetBrainsMono Nerd Font";

      # Padding
      window-padding-x = 0;
      window-padding-y = 0;

      # Links
      link-url = true;
      link-previews = true;

      # Shell integration (enables CWD tracking, cursor shape at prompt, sudo title)
      shell-integration = "zsh";
      shell-integration-features = "cursor,sudo,title";
      window-inherit-working-directory = false;

      # Cursor
      cursor-style = "bar";
      cursor-style-blink = true;

      # Mouse
      mouse-hide-while-typing = true;

      # Clipboard
      copy-on-select = true;
      clipboard-trim-trailing-spaces = true;

      # Scrollback
      scrollbar = "never";

      # Rendering
      alpha-blending = "linear-corrected";
    };
  };
}
