{
  description = "My NixOS configurations";

  inputs = {
    # Specifies the URL for the NixOS 24.05 release of the Nixpkgs repository.
    # This input is used to access the Nixpkgs package set for the 24.05 NixOS release.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    # Specifies the URL for the NixOS hardware configuration repository.
    # This input is used to access the hardware configurations provided by the NixOS project.
    # The hardware configurations can be used to configure the hardware-specific aspects of a NixOS system.
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Specifies the URL for the NixOS unstable Nixpkgs repository.
    # This input is used to access the Nixpkgs package set for the unstable NixOS release.
    # The unstable Nixpkgs repository is used for some packages that are not available in the stable release.
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # The home-manager input specifies the URL for the Home Manager repository,
    # which is used to manage user-specific configurations.
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
      };
    };

    # Delta is a syntax-highlighting pager for git, diff, and grep output.
    # NOTE: Include just for "themes.gitconfig" file
    delta = {
      url = "github:dandavison/delta";
      flake = false;
    };

    # Dracula Wallpaper
    #
    # This input provides access to the Dracula theme wallpaper repository.
    # The wallpapers can be used to customize the appearance of your system.
    dracula-wallpaper = {
      url = "github:dracula/wallpaper";
      flake = false;
    };

    # Dracula Theme for Alacritty
    dracula-alacritty-theme = {
      url = "github:dracula/alacritty";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in rec {
    # My custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};

    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;

    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    homeManagerModules = import ./modules/home-manager;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild switch --flake .#nixie-ci'
    nixosConfigurations = {
      nixie-ci = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;}; # Pass flake inputs and outputs to the config
        modules = [
          # My main nixos configuration file
          ./nixos/configuration.nix
          inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager switch --flake .#mohammad@nixie-ci'
    homeConfigurations = {
      "nixie-ci" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home Manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./home-manager/nixie-ci.nix
        ];
      };
      "nixie-lab" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home Manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./home-manager/nixie-lab.nix
        ];
      };
    };
  };
}
