# Nixie [![built with nix](https://img.shields.io/badge/Built_with_Nix-7EBAE4?style=flat&logo=nixos&logoColor=white&labelColor=5277C3)](https://builtwithnix.org)

This repository contains the NixOS configuration and dotfiles for my machines, collectively named **Nixie**. It includes settings for various tools and applications, such as system services, window managers, terminal emulators, and text editors. By sharing these configurations, others can learn from my setup and adapt it to their own needs.

## Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Structure](#structure)
- [Customization](#customization)
- [Secrets and Sensitive Data](#secrets-and-sensitive-data)
- [Acknowledgements](#acknowledgements)
- [License](#license)

## Overview

The purpose of this repository is to provide a well-organized, version-controlled, and easily maintainable configuration for NixOS. It aims to simplify managing a personal computing environment and ensure consistency across multiple devices. The name **Nixie** reflects the project's modular and elegant approach to NixOS customization.

## Prerequisites

Before using this configuration, ensure you have the following:

- A **NixOS-based system**
- **Git** installed

## Installation

To set up Nixie on your system, follow these steps:

1. Clone the repository:

   ```sh
   git clone https://github.com/atkrad/nixie.git ~/.nixie
   ```

2. Apply the NixOS configuration:

   ```sh
   sudo nixos-rebuild switch --flake ~/.nixie#nixie-ci
   ```

3. Apply the Home Manager configuration (replace `mohammad@nixie-ci` with your username and hostname if different):

   ```sh
   home-manager switch --flake ~/.nixie#mohammad@nixie-ci
   ```

4. Restart your system to ensure all changes take effect:

   ```sh
   systemctl reboot -i
   ```

## Structure

The repository is organized as follows:

- `nixos/`: Contains system-wide configurations, including the main `configuration.nix`.
- `home-manager/`: Configurations for user-specific settings, such as shell aliases and editor preferences.
- `modules/`: Modular configurations for specific services or applications (e.g., Docker, Kubernetes).
- `overlays/`: Custom Nix package definitions or overrides.
- `pkgs/`: Custom Nix packages defined similarly to `nixpkgs`.

This modular structure ensures a clean and maintainable configuration that can be easily extended or reused.

## Customization

To customize the configuration, modify the relevant files within the repository. Be sure to test your changes before committing them to ensure they work as expected.

### Example: Adding a New Package

1. Edit the Home Manager configuration to include the desired package:

   ```nix
   home.packages = with pkgs; [
     vim
     firefox
     # Add your package here
   ];
   ```

2. Apply the changes:

   ```sh
   home-manager switch --flake ~/.nixie#mohammad@nixie-ci
   ```

3. (Optional) Preview changes before applying them:

   ```sh
   nixos-rebuild dry-run --flake ~/.nixie#nixie-ci
   ```

## Secrets and Sensitive Data

Avoid committing sensitive information (e.g., API keys, passwords). Instead, use tools like **git-crypt** or environment variables to manage secrets securely.

## Acknowledgements

This repository is inspired by the work and ideas of numerous NixOS community members. Special thanks to the maintainers of **NixOS**, **Home Manager**, and related projects for their invaluable contributions.

Feel free to use, adapt, and share this configuration as needed, but please give credit where it's due.

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
