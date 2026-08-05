{
  pkgs,
  ...
}:
let
  githubUser = "atkrad";
  vaultName = "notes";

  obsidianPluginGit = pkgs.callPackage ./plugins/obsidian-git { };
  obsidianPluginAdvancedTables = pkgs.callPackage ./plugins/advanced-tables { };
  obsidianThemeDracula = pkgs.callPackage ./themes/dracula { };
in
{
  programs.obsidian = {
    enable = true;
    cli.enable = true;
    package = pkgs.obsidian;

    defaultSettings = {
      appearance = {
        baseFontSize = 16;
        theme = "obsidian";
      };

      themes = [
        {
          pkg = obsidianThemeDracula;
          enable = true;
        }
      ];

      communityPlugins = [
        {
          pkg = obsidianPluginGit;
          settings = {
            commitMessage = "vault backup: {{date}}";
            autoCommitMessage = "vault backup: {{date}}";
            commitDateFormat = "YYYY-MM-DD HH:mm:ss";
            autoSaveInterval = 15;
            autoPullInterval = 0;
            autoPullOnBoot = true;
            disablePush = false;
            pullBeforePush = true;
            syncMethod = "merge";
            disablePopups = true;
            showStatusBar = true;
            autoBackupAfterFileChange = false;
          };
        }
        { pkg = obsidianPluginAdvancedTables; }
      ];
    };

    vaults.${vaultName} = {
      target = "Workspace/github.com/${githubUser}/${vaultName}";
    };
  };
}
