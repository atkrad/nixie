{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.starship = {
    enable = true;
    settings = {
      php.symbol = " ";
      aws = {
        style = "bold orange";
        symbol = "  ";
      };
      buf.symbol = " ";
      c.symbol = " ";
      conda.symbol = " ";
      crystal.symbol = " ";
      cmd_duration.style = "bold yellow";
      dart.symbol = " ";
      directory = {
        read_only = " 󰌾";
        style = "bold green";
      };
      docker_context.symbol = " ";
      elixir.symbol = " ";
      elm.symbol = " ";
      fennel.symbol = " ";
      fossil_branch.symbol = " ";

      git_branch = {
        symbol = " ";
        style = "bold pink";
      };

      git_commit = {
        tag_symbol = "  ";
        tag_disabled = false;
      };

      git_metrics = {
        disabled = false;
        ignore_submodules = true;
        only_nonzero_diffs = true;
        format = "([\\[](bold blue)[+$added]($added_style)[/](bold bright-blue)[-$deleted]($deleted_style)[\\]](bold blue) )";
      };

      golang.symbol = " ";
      guix_shell.symbol = " ";
      haskell.symbol = " ";
      haxe.symbol = " ";
      hg_branch.symbol = " ";

      hostname = {
        ssh_symbol = " ";
        style = "bold purple";
      };
      java.symbol = " ";
      julia.symbol = " ";
      kotlin.symbol = " ";
      lua.symbol = " ";
      memory_usage.symbol = "󰍛 ";
      meson.symbol = "󰔷 ";
      nim.symbol = "󰆥 ";
      nix_shell = {
        symbol = " ";
        # Attempts to detect new nix shell-style shells with a heuristic.
        heuristic = true;
      };
      nodejs.symbol = " ";
      ocaml.symbol = " ";

      os.symbols = {
        Linux = " ";
        NixOS = " ";
        Raspbian = " ";
        Unknown = " ";
      };
      git_status.style = "bold red";
      helm.symbol = "☸️  ";
      username = {
        format = "[$user]($style) on ";
        style_user = "bold cyan";
      };
      character = {
        success_symbol = "[λ](bold green)";
        error_symbol = "[λ](bold red)";
      };
      sudo = {
        disabled = false;
        style = "bold green";
      };

      # Use the color palette
      palette = "dracula";
      # Timeout for commands executed by starship (in milliseconds).
      command_timeout = 20000;

      # Define Dracula color palette
      palettes.dracula = {
        background = "#282a36";
        current_line = "#44475a";
        foreground = "#f8f8f2";
        comment = "#6272a4";
        cyan = "#8be9fd";
        green = "#50fa7b";
        orange = "#ffb86c";
        pink = "#ff79c6";
        purple = "#bd93f9";
        red = "#ff5555";
        yellow = "#f1fa8c";
      };
    };
  };
}
