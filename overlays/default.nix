# This file defines overlays
{ inputs, ... }:
{
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
    # cato-client = prev.cato-client.overrideAttrs (oldAttrs: {
    #   version = "5.5.0.2620";
    #   src = final.fetchurl {
    #     url = "https://clients.catonetworks.com/linux/5.5.0.2620/cato-client-install.deb";
    #     sha256 = "sha256-V1BhgLOHP/pGlwvjVFdNslKupjHBVSTDVIRtZ6amwbk=";
    #   };
    # });

    # To update Cursor:
    # 1. Get the latest version and build hash from the update API:
    #    curl -s "https://api2.cursor.sh/updates/api/update/linux-x64/cursor/0.0.0/0000000000000000000000000000000000000000000000000000000000000000/dev"
    # 2. Update `version` and the build hash in the URL below.
    # 3. Set hash to "" and run `nix build .#nixosConfigurations.nixie-ci.pkgs.code-cursor` to get the new hash.
    code-cursor =
      let
        version = "3.12.17";
        pname = "cursor";
        appImageSrc = final.fetchurl {
          url = "https://downloads.cursor.com/production/0fb762053c34788bb7760d5673f8a6d4c8589d52/linux/x64/Cursor-${version}-x86_64.AppImage";
          hash = "sha256-AZ11x50kcAqYxgOGLYfcZhOiNYUNVPsY143gch5jT9o=";
        };
      in
      prev.code-cursor.overrideAttrs (oldAttrs: {
        inherit version;
        src = final.appimageTools.extract {
          inherit pname version;
          src = appImageSrc;
        };
        sourceRoot = "${pname}-${version}-extracted/usr/share/cursor";
      });

    # To update cursor-cli:
    # 1. Get the latest build tag:
    #    curl -fsS https://cursor.com/install | grep -oP 'downloads\.cursor\.com/lab/\K[0-9]{4}\.[0-9]{2}\.[0-9]{2}-[a-f0-9]+'
    # 2. Update the date-hash in the URL and version below.
    # 3. Set hash to "" and run `nix build .#nixosConfigurations.nixie-ci.pkgs.cursor-cli` to get the new hash.
    cursor-cli =
      let
        version = "0-unstable-2026-07-16";
        src = final.fetchurl {
          url = "https://downloads.cursor.com/lab/2026.07.16-899851b/linux/x64/agent-cli-package.tar.gz";
          hash = "sha256-EGrPazo3gc0nkDhyarxPefmHRJufUhmw9uYtlsiP7m0=";
        };
      in
      prev.cursor-cli.overrideAttrs (_oldAttrs: {
        inherit version src;
      });

    # Bump GPaste to 50.5 for GNOME 50. nixpkgs' fix-paths.patch still
    # targets the braced else from 45.x, so use a 50.5-compatible patch.
    gpaste = prev.gpaste.overrideAttrs (oldAttrs: rec {
      version = "50.5";
      src = final.fetchurl {
        url = "https://www.imagination-land.org/files/gpaste/GPaste-${version}.tar.xz";
        hash = "sha256-bPOO7JoYhytwkknVB68y7NxCiwL4N9pe7TtxlEE5M+Q=";
      };
      patches = [ ./gpaste-fix-paths.patch ];
      postPatch = ''
        substituteInPlace src/libgpaste/gpaste/gpaste-settings.c \
          --subst-var-by gschemasCompiled ${final.glib.makeSchemaPath (placeholder "out") "gpaste-${version}"}
      '';
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
    unstable = prev.unstable.extend (
      final': prev':
      let
        nvim-dap-fixed = prev'.vimPlugins.nvim-dap.overrideAttrs (old: {
          src = prev'.fetchFromGitHub {
            owner = "mfussenegger";
            repo = "nvim-dap";
            rev = "531771530d4f82ad2d21e436e3cc052d68d7aebb";
            hash = "sha256-pgD51NWFyjK1FrXZ8MFFIM9DX2OBxL7cd7JlST2Twvc=";
          };
        });
        replaceDap =
          deps: builtins.map (dep: if (dep.pname or "") == "nvim-dap" then nvim-dap-fixed else dep) deps;
      in
      {
        vimPlugins = prev'.vimPlugins // {
          nvim-dap = nvim-dap-fixed;
          nvim-dap-ui = prev'.vimPlugins.nvim-dap-ui.overrideAttrs (old: {
            dependencies = replaceDap (old.dependencies or [ ]);
            passthru = (old.passthru or { }) // {
              dependencies = replaceDap (old.passthru.dependencies or old.dependencies or [ ]);
            };
          });
          nvim-dap-virtual-text = prev'.vimPlugins.nvim-dap-virtual-text.overrideAttrs (old: {
            dependencies = replaceDap (old.dependencies or [ ]);
            passthru = (old.passthru or { }) // {
              dependencies = replaceDap (old.passthru.dependencies or old.dependencies or [ ]);
            };
          });
        };
      }
    );
  };
}
