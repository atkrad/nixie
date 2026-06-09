{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    ghq
  ];

  programs.git = {
    enable = true;
    settings = {
      user.name = "Mohammad Abdolirad";
      user.email = "m.abdolirad@gmail.com";
      format.signoff = true;
      diff.colorMoved = "default";
      ghq = {
        vcs = "git";
        root = "~/Workspace";
      };
      merge.conflictstyle = "zdiff3";
      pager = {
        reflog = "delta";
      };
      url = {
        "git@gitlab.ci.fdmg.org:".insteadOf = "https://gitlab.ci.fdmg.org/";
      };
    };
    signing = {
      signByDefault = true;
      key = "62CAFDB8";
    };
    ignores = [
      ".idea" # Jetbrains
      ".cursor" # Cursor AI
      ".vscode" # VS Code
      ".direnv" # direnv
      ".claude" # Claude AI
    ];
    includes = [
      {
        path = "${inputs.delta}/themes.gitconfig";
      }
      {
        condition = "gitdir:~/Workspace/gitlab.ci.fdmg.org/";
        contents = {
          user = {
            name = "Mohammad Abdolirad";
            email = "mohammad.abdolirad@company.info";
            signingKey = "62CAFDB8";
          };
        };
      }
    ];
  };
}
