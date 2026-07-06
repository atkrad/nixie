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

### Neovim leader keymaps

Leader is `Space`. In insert mode, `Alt-Space` exits insert and opens the leader menu. Bindings are defined in `home-manager/modules/neovim/lua/doom/keymaps/`. Press `Space` then wait for which-key, or use the cheatsheet below.

#### Root (`Space`)

| Key | Action |
| ----- | -------- |
| `;` | Eval expression |
| `:` | Commands (Telescope) |
| `.` | Find file |
| `,` | Switch buffer |
| `` ` `` | Switch to last buffer |
| `'` | Resume last search |
| `*` | Search symbol in project |
| `/` | Search project |
| `Space` | Find file in project |
| `Enter` | Jump to mark |
| `x` | Toggle scratch buffer |
| `b` | Buffer menu |
| `c` | Code menu |
| `d` | Debugger menu |
| `f` | File menu |
| `g` | Git menu |
| `h` | Help menu |
| `o` | Open menu |
| `p` | Project menu |
| `q` | Quit and session menu |
| `s` | Search menu |
| `t` | Toggle menu |
| `w` | Window menu |
| `Tab` | Session menu |

#### Buffer (`Space b`)

| Key | Action |
| ----- | -------- |
| `[` | Previous buffer |
| `]` | Next buffer |
| `b` | Switch buffer |
| `d` | Close buffer |
| `K` | Close all buffers |
| `l` | Switch to last buffer |
| `N` | New empty buffer |
| `O` | Close other buffers |
| `r` | Revert buffer |
| `R` | Rename buffer |
| `s` | Save buffer |
| `S` | Save all buffers |
| `x` | Open scratch buffer |
| `X` | Switch to scratch buffer |
| `y` | Yank buffer |
| `z` | Hide buffer |
| `Z` | Close hidden buffers |

#### Code (`Space c`)

| Key | Action |
| ----- | -------- |
| `c` | Compile (`make`) |
| `C` | Recompile (`make clean`, then `make`) |
| `d` | Go to definition |
| `D` | References |
| `f` | Format buffer |
| `i` | Implementations |
| `k` | Documentation |
| `t` | Type definition |
| `w` | Trim trailing whitespace |
| `x` | Diagnostics |
| `a` | Code action |
| `l` | LSP info |
| `r` | Rename |
| `S` | Document symbols |
| `j` | Workspace symbols |
| `J` | All workspace symbols |

#### Debugger (`Space d`)

| Key | Action |
| ----- | -------- |
| `d` | Debug test |
| `c` | Continue |
| `n` | Step over |
| `s` | Step into |
| `o` | Step out |
| `i` | Debug UI |
| `R` | Debug REPL |
| `e` | Conditional breakpoint |
| `b` | Toggle breakpoint |
| `B` | Clear breakpoints |
| `x` | Evaluate expression |
| `D` | Terminate session |

#### File (`Space f`)

| Key | Action |
| ----- | -------- |
| `d` | File tree |
| `D` | Delete file |
| `f` | Find file |
| `F` | Find file (here) |
| `p` | Find file in config |
| `r` | Recent files |
| `s` | Save file |
| `S` | Save file as |
| `y` | Yank file path |
| `Y` | Yank project-relative path |

#### Git (`Space g`)

| Key | Action |
| ----- | -------- |
| `R` | Revert file |
| `r` | Revert hunk |
| `s` | Stage hunk |
| `]` | Next hunk |
| `[` | Previous hunk |
| `b` | Switch branch |
| `g` | Git status |
| `G` | Git status (here) |
| `B` | Git blame |
| `F` | Git fetch |
| `L` | Git log |
| `S` | Stage file |
| `U` | Unstage file |
| `f f` | Git files |
| `f c` | Git commits |
| `c c` | Commit |
| `c b` | Branch |

#### Help (`Space h`)

| Key | Action |
| ----- | -------- |
| `W` | Man pages |
| `a` | Search help |
| `F` | Highlights |
| `t` | Colorscheme |
| `v` | Options |
| `k` | Keymaps |
| `m` | Filetype |
| `i` | Help |
| `d b` | Check health |
| `d c` | Open config |
| `d v` | Version |
| `r r` | Reload config |
| `r t` | Reload colorscheme |

#### Open (`Space o`)

| Key | Action |
| ----- | -------- |
| `f` | New tab |
| `p` | Project sidebar |
| `P` | Reveal file in tree |
| `t` | Toggle terminal (float) |
| `T` | Open terminal (split) |

#### Project (`Space p`)

| Key | Action |
| ----- | -------- |
| `.` | Browse project |
| `b` | Project buffers |
| `f` | Find file in project |
| `k` | Close other buffers |
| `p` | Switch project |
| `r` | Recent project files |
| `s` | Save all files |
| `x` | Toggle scratch buffer |
| `X` | Switch to scratch buffer |

#### Quit and session (`Space q`)

| Key | Action |
| ----- | -------- |
| `f` | Close window |
| `F` | Close all buffers |
| `q` | Quit |
| `Q` | Quit without saving |
| `s` | Save session |
| `l` | Restore last session |
| `L` | Restore session (pick) |
| `r` | Reload config |

#### Search (`Space s`)

| Key | Action |
| ----- | -------- |
| `b` | Search buffer |
| `B` | Search open buffers |
| `d` | Search directory |
| `D` | Search other directory |
| `i` | Document symbols |
| `I` | Workspace symbols (all) |
| `j` | Jumplist |
| `m` | Marks |
| `p` | Search project |
| `P` | Search other project |
| `S` | Search word under cursor |

#### Toggle (`Space t`)

| Key | Action |
| ----- | -------- |
| `c` | Color column |
| `d` | Git blame (line) |
| `I` | Expand tab |
| `l` | Line numbers |
| `r` | Read-only |
| `s` | Spell check |
| `w` | Line wrap |

#### Window (`Space w`)

| Key | Action |
| ----- | -------- |
| `h` `j` `k` `l` | Focus left, down, up, right |
| `w` | Other window |
| `W` | Previous window |
| `v` | Split vertical |
| `s` | Split horizontal |
| `o` | Close other windows |
| `c` | Close window |
| `q` | Quit window |
| `=` | Balance windows |
| `m` | Maximize |
| `H` `J` `K` `L` | Move window left, down, up, right |
| `r` | Rotate windows |
| `-` `+` `_` | Decrease, increase, max height |
| `<` `>` `\|` | Decrease, increase, max width |

#### Session (`Space Tab`)

| Key | Action |
| ----- | -------- |
| `.` | Switch session |
| `` ` `` | Restore last session |

#### Other Neovim keys

| Key | Action |
| ----- | -------- |
| `gd` | Go to definition |
| `K` | Hover documentation |
| `Tab` / `Shift-Tab` | Next / previous buffer |
| `gb` | Pick buffer |
| `gD` | Pick buffer to close |

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

> Copyright 2022-2026 Mohammad Abdolirad
>
> Licensed under the Apache License, Version 2.0 (the "License");
> you may not use this file except in compliance with the License.
> You may obtain a copy of the License at
>
> <https://www.apache.org/licenses/LICENSE-2.0>
>
> Unless required by applicable law or agreed to in writing, software
> distributed under the License is distributed on an "AS IS" BASIS,
> WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
> See the License for the specific language governing permissions and
> limitations under the License.
