# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    outputs.nixosModules.cato-client

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # I also split up my configuration and import pieces of it here:
    ./fonts
    ./locate
    ./gnupg
    ./nix-ld
    ./ollama

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Disable global registry
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };
    # Disable channels
    channel.enable = false;

    # Make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  boot = {
    kernelParams = ["i915.fastboot=1"];
    kernelModules = ["i915" "kvm-amd" "kvm-intel"];
    supportedFilesystems = ["ntfs"];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 10;
      # Use the systemd-boot EFI boot loader.
      systemd-boot.enable = true;
    };
  };

  networking = {
    hostName = "nixie-ci";
    hostId = "932d7537"; # head -c4 /dev/urandom | od -A none -t x4
    nameservers = ["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];
  };

  networking.firewall = {
    enable = true;
    allowPing = false;
    allowedTCPPorts = [8080];
  };

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager = {
    enable = true; # Easiest to use and most distros use this by default.

    # one of "OFF", "ERR", "WARN", "INFO", "DEBUG", "TRACE"
    logLevel = "INFO";

    dns = "systemd-resolved";

    # may generate problems
    wifi = {
      scanRandMacAddress = false;
      powersave = false;
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    earlySetup = true;
    font = "ter-powerline-v32n";
    keyMap = "us";
    packages = with pkgs; [
      terminus_font
      powerline-fonts
    ];
    colors = [
      "282a36" # redefine 'black'          as 'dracula-bg'
      "6272a4" # redefine 'bright-black'   as 'dracula-comment'
      "ff5555" # redefine 'red'            as 'dracula-red'
      "ff7777" # redefine 'bright-red'     as '#ff7777'
      "50fa7b" # redefine 'green'          as 'dracula-green'
      "70fa9b" # redefine 'bright-green'   as '#70fa9b'
      "f1fa8c" # redefine 'brown'          as 'dracula-yellow'
      "ffb86c" # redefine 'bright-brown'   as 'dracula-orange'
      "bd93f9" # redefine 'blue'           as 'dracula-purple'
      "cfa9ff" # redefine 'bright-blue'    as '#cfa9ff'
      "ff79c6" # redefine 'magenta'        as 'dracula-pink'
      "ff88e8" # redefine 'bright-magenta' as '#ff88e8'
      "8be9fd" # redefine 'cyan'           as 'dracula-cyan'
      "97e2ff" # redefine 'bright-cyan'    as '#97e2ff'
      "f8f8f2" # redefine 'white'          as 'dracula-fg'
      "ffffff" # redefine 'bright-white'   as '#ffffff'
    ];
  };

  # X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    # Enable the GNOME Desktop Environment.
    desktopManager.gnome.enable = true;
    excludePackages = [pkgs.xterm];
    xkb = {
      # Configure keymap in X11
      layout = "us";
    };
  };

  services.resolved = {
    enable = true;
    dnssec = "false";
    dnsovertls = "opportunistic";
    domains = ["~."];
    fallbackDns = [
      "8.8.8.8"
      "2001:4860:4860::8888"
      "8.8.4.4"
      "2001:4860:4860::8844"
    ];
    extraConfig = "MulticastDNS=true";
  };

  # Enable fingerprint
  services.fprintd.enable = false;
  security.pam.services.login.fprintAuth = false;

  # fwupd is a simple daemon allowing you to update some devices' firmware.
  services.fwupd.enable = true;

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = with pkgs; [hplip];
  };

  services.flatpak.enable = true;

  services.cato-client.enable = true;

  services.udev.packages = with pkgs; [
    vial
    via
  ];

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Accelerated Video Playback
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
  };
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-media-driver
      libGL
      libGLU
    ];
  };

  # Docker
  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      dates = "weekly"; # Specification (in the format described by systemd.time(7)) of the time at which the prune will occur.
    };
  };

  security.polkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  programs.gpaste.enable = true;
  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mohammad = {
    isNormalUser = true;
    extraGroups = ["wheel" "docker"]; # Enable ‘sudo’ for the user.
    initialPassword = "nixie";
    shell = pkgs.zsh;
  };

  environment = {
    # ZSH link for system package completion
    pathsToLink = ["/share/zsh"];
    shells = [pkgs.zsh pkgs.bash];
    # List packages installed in system profile.
    systemPackages = with pkgs; [
      nano
      wget
      pciutils
      usbutils
      gparted
      nixd
    ];
    gnome.excludePackages = with pkgs; [
      baobab
      epiphany
      gnome-tour
      gnome-photos
      gnome-connections
      totem
      geary
      gnome-logs
      gnome-maps
      simple-scan
      gnome-music
      gnome-contacts
      gnome-characters
      gnome-disk-utility
    ];
    # Note: https://github.com/NixOS/nixpkgs/issues/195936
    sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 = lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" [
      pkgs.gst_all_1.gst-plugins-good
      pkgs.gst_all_1.gst-plugins-bad
      pkgs.gst_all_1.gst-plugins-ugly
      pkgs.gst_all_1.gst-plugins-base
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
