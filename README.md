# My Flake

This flake holds the configurations for all my machines and my user accross
those machines

HOSTS :

- waylander : laptop config
- druss : battlestation, maximal config
- delnoch : server, cli and shell, docker (WIP), only host still not on nixos,
  HM on debian
- wsl : windows subsystem for linux
- min : minimal

All configs can be used for home-manager standalone or nixos (with home-manager
as a module).

TODO :

- rewrite variable as true options
- [x] programming languages in nix shells
- [ ] rewrite an modularize the whole config
  - [x] waylander
  - [x] druss
  - [ ] delnoch
  - [x] wsl
  - [x] min
- [x] ajouter une config nvf minimaliste

```
.
├── flake.lock
├── flake.nix
├── variables.nix
├── nvf.nix
├── shells.nix
├── README.md
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
│   │   └── packages.nix
│   ├── keyboard.nix
│   ├── packages.nix
│   ├── shell
│   │   ├── default.nix
│   │   ├── fish.nix
│   │   ├── starship.nix
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
│   │   ├── security.nix
│   │   └── swap.nix
│   └── wsl
│       ├── configuration.nix
│       └── default.nix
└── system
    ├── amd-drivers.nix
    ├── boot.nix
    ├── default.nix
    ├── flatpak.nix
    ├── fonts.nix
    ├── gaming.nix
    ├── keyboard.nix
    ├── locale.nix
    ├── local-hardware-clock.nix
    ├── login.nix
    ├── network.nix
    ├── nix.nix
    ├── openrgb.nix
    ├── systemVersion.nix
    ├── time.nix
    ├── user.nix
    └── wayland.nix

9 directories, 49 files
```
