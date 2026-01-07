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
    cato-client = prev.cato-client.overrideAttrs (oldAttrs: {
      version = "5.5.0.2620";
      src = final.fetchurl {
        url = "https://clients.catonetworks.com/linux/5.5.0.2620/cato-client-install.deb";
        sha256 = "sha256-V1BhgLOHP/pGlwvjVFdNslKupjHBVSTDVIRtZ6amwbk=";
      };
    });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    };
  };

  # Overlay for unstable packages modifications
  unstable-modifications = final: prev: {
    unstable = prev.unstable.extend (final': prev': {
      # Temporarily disable the cursor override to use the original package
      # code-cursor = prev'.code-cursor.overrideAttrs (oldAttrs: {
      #   version = "1.3.5";
      #   src = final.appimageTools.extract {
      #     pname = "cursor";
      #     version = "1.3.5";
      #     src = final.fetchurl {
      #       url = "https://downloads.cursor.com/production/9f33c2e793460d00cf95c06d957e1d1b8135fadd/linux/x64/Cursor-1.3.5-x86_64.AppImage";
      #       sha256 = "sha256-gfnBizwsToXnL3TmrkW/lTTefo+cN6UPJXU3JELsRTQ=";
      #     };
      #   };
      #   sourceRoot = "cursor-1.3.5-extracted/usr/share/cursor";
      #   preInstall = ''
      #     mkdir -p bin
      #     rm -f bin/cursor
      #     ln -s ../lib/cursor/cursor bin/cursor
      #   '';
      # });
    });
  };
}
