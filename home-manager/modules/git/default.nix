{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    ghq
  ];

  programs.git = {
    enable = true;
    userName = "Mohammad Abdolirad";
    userEmail = "m.abdolirad@gmail.com";
    signing = {
      signByDefault = true;
      key = "62CAFDB8";
    };
    delta = {
      enable = true;
      options = {
        features = "decorations mellow-barbet interactive";
        syntax-theme = "Dracula";
        line-numbers = true;
        navigate = true;
        side-by-side = true;
	true-color = "always";
      };
    };
    ignores = [
      ".idea" # Jetbrains
    ];
    extraConfig = {
      format.signoff = true;
      diff.colorMoved = "default";
      ghq = {
        vcs = "git";
        root = "~/Workspace";
      };
      merge.conflictstyle = "zdiff3";
      pager = {
        diff = "delta";
        log = "delta";
        reflog = "delta";
        show = "delta";
        blame = "delta";
      };
			#      interactive.diffFilter = "delta --color-only";
      url = {
        "git@gitlab.ci.fdmg.org:".insteadOf = "https://gitlab.ci.fdmg.org/";
      };
    };
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
