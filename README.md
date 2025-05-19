# Nixie [![built with nix](https://img.shields.io/badge/Built_with_Nix-7EBAE4?style=flat&logo=nixos&logoColor=white&labelColor=5277C3)](https://builtwithnix.org)

This repository contains the NixOS configuration and dotfiles for my machines, collectively named **Nixie**. It includes settings for various tools and applications, such as system services, window managers, terminal emulators, and text editors. By sharing these configurations, others can learn from my setup and adapt it to their own needs.

## Overview

The purpose of this repository is to provide a well-organized, version-controlled, and easily maintainable configuration for NixOS. It aims to simplify managing a personal computing environment and ensure consistency across multiple devices. The name **Nixie** reflects the project's modular and elegant approach to NixOS customization.

## Prerequisites

Before using this configuration, ensure you have the following:

- A **NixOS-based system**
- **Git** installed

## Installation and Usage

### Bootstrap a New Machine

1. **Install Nix (with flakes enabled):**
   ```sh
   sh <(curl -L https://nixos.org/nix/install)
   # Enable flakes in /etc/nix/nix.conf:
   # experimental-features = nix-command flakes
   ```
2. **Clone this repository:**
   ```sh
   git clone https://github.com/yourusername/nixie.git
   cd nixie
   ```
3. **Install Home Manager (if not on NixOS):**
   ```sh
   nix run .#homeConfigurations.nixie-ci.activationPackage
   # or for a different profile:
   nix run .#homeConfigurations.nixie-lab.activationPackage
   ```
4. **For NixOS system config:**
   ```sh
   sudo nixos-rebuild switch --flake .#nixie-ci
   ```

### Update and Roll Back

- **Update flake inputs:**
  ```sh
  nix flake update
  git add flake.lock
  git commit -m "Update flake inputs"
  ```
- **Apply updates:**
  ```sh
  home-manager switch --flake .#nixie-ci
  # or for system:
  sudo nixos-rebuild switch --flake .#nixie-ci
  ```
- **Roll back:**
  - For Home Manager: `home-manager generations`
  - For NixOS: `sudo nixos-rebuild --rollback`

### Repository Structure

The repository is organized as follows:

- `nixos/`: Contains system-wide configurations, including the main `configuration.nix`
- `home-manager/`: Configurations for user-specific settings, such as shell aliases and editor preferences
- `modules/`: Modular configurations for specific services or applications (e.g., Docker, Kubernetes)
- `overlays/`: Custom Nix package definitions or overrides
- `pkgs/`: Custom Nix packages defined similarly to `nixpkgs`

### Adding New Components

#### Modules
- **Home Manager module:**
  1. Create a new file in `home-manager/modules/yourmodule/default.nix`
  2. Import it in `home-manager/nixie-ci.nix` or `nixie-lab.nix` under `imports`
- **NixOS module:**
  1. Create a new file in `nixos/yourmodule/default.nix`
  2. Import it in `nixos/configuration.nix` under `imports`

#### Packages
- Add to `home.packages` (user) or `environment.systemPackages` (system)
- Example:
  ```nix
  home.packages = with pkgs; [
    vim
    firefox
    # Add your package here
  ];
  ```

### Troubleshooting Guide

#### LSP/Neovim
- Run `:checkhealth` in Neovim for diagnostics
- Ensure LSP servers are installed (via Mason or Nix)
- Check `$PATH` for LSP binaries

#### GPU/Video Acceleration
- Test with `vainfo` and `vdpauinfo`
- For browser acceleration, check `chrome://gpu` or `about:support`
- Ensure correct drivers in `hardware.graphics.extraPackages`

#### Audio
- Use `pavucontrol` to manage audio devices
- Restart Pipewire: `systemctl --user restart pipewire`

#### General Nix Issues
- Run `nix doctor` for diagnostics
- Check logs: `/var/log/messages` or `journalctl -xe`

### Secrets Management

Avoid committing sensitive information (e.g., API keys, passwords). Instead, use tools like **git-crypt** or environment variables to manage secrets securely.

## Acknowledgements

This repository is inspired by the work and ideas of numerous NixOS community members. Special thanks to the maintainers of **NixOS**, **Home Manager**, and related projects for their invaluable contributions.

For more details, see the [NixOS Wiki](https://nixos.wiki/) and [Home Manager Manual](https://nix-community.github.io/home-manager/).

## License

Copyright 2022-2025 Mohammad Abdolirad

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
