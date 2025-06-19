# My Flake

# WIP, README NOT UP TO DATE

This flake holds the configurations for all my machines and my user across those machines, my shells for developing and my nvf config.

## HOSTS

- waylander : laptop config
- druss : battle station, maximal config
- delnoch : server, cli and shell, docker (WIP), only host still not on Nixos, HM on Debian
- wsl : windows subsystem for Linux

All configs can be used for home-manager standalone or nixos (with home-manager as a module).

## TODO

- [ ] rewrite an modularize the whole config
  - [x] waylander
  - [x] druss
  - [ ] delnoch
  - [x] wsl
- [ ] nvf
    - [x] ajouter une config nvf minimaliste
    - [ ] better theme management

## NVF

Currently I output my nvf config as an output package ([relevant manual part](https://notashelf.github.io/nvf/index.xhtml#ch-standalone-installation)).

It allows me to import it as part of my config in my package with `self.packages."${system}".nvf-max`.

The nvf config itself is located at ./nvf.nix, and imported by the flake, the `max` argument allows to have a big config, and a smaller one (which is not that small actually).


## Structure

```shell
.
├── flake.lock
├── flake.nix
├── home
│   ├── default.nix
│   ├── env.nix
│   ├── fonts.nix
│   ├── gaming.nix
│   ├── git.nix
│   ├── home.nix
│   ├── hypr
│   │   ├── default.nix
│   │   ├── hyprland.nix
│   │   ├── packages.nix
│   │   └── stylix.nix
│   ├── keyboard.nix
│   ├── packages.nix
│   ├── shell
│   │   ├── default.nix
│   │   ├── fish.nix
│   │   ├── kitty.nix
│   │   ├── pay-respects.nix
│   │   ├── starship.nix
│   │   ├── tmux.nix
│   │   ├── zellij.nix
│   │   └── zoxide.nix
│   └── zen.nix
├── hosts
│   ├── druss
│   │   ├── default.nix
│   │   └── hardware.nix
│   ├── waylander
│   │   ├── default.nix
│   │   ├── hardware.nix
│   │   ├── kanata.nix
│   └── wsl
│       ├── configuration.nix
│       └── default.nix
├── nvf.nix
├── README.md
├── shells.nix
├── system
│   ├── amd-drivers.nix
│   ├── boot.nix
│   ├── default.nix
│   ├── flatpak.nix
│   ├── fonts.nix
│   ├── gaming.nix
│   ├── keyboard.nix
│   ├── locale.nix
│   ├── login.nix
│   ├── network.nix
│   ├── nix.nix
│   ├── openrgb.nix
│   ├── shell.nix
│   ├── stylix.nix
│   ├── systemVersion.nix
│   ├── time.nix
│   ├── user.nix
│   └── wayland.nix
└── variables.nix

9 directories, 53 files
```
