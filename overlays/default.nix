# This file defines overlays
{inputs, ...}: {
  # This one brings my custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
    # dracula-theme = prev.dracula-theme.overrideAttrs (oldAttrs: {
    #  version = "4.0.0";
    #  src = final.fetchFromGitHub {
    #    owner = "dracula";
    #    repo = "gtk";
    #    rev = "f77cf5caeac0ad7d71c8e568f699a197a100e75a";
    #    sha256 = "sha256-0GO6Y0S7d4zQX7DJFF/l0RuPOw3NaI1wh4/8AJqOqDo=";
    #  };
    #});
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
