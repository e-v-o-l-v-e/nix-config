# My Flake

modular config.

HOSTS :

- delnoch : server, cli and shell, docker
- min : minimal
- waylander : laptop config
- druss : battlestation, maximal config
- wsl : windows subsystem for linux

All configs can be used for home-manager standaone or nixos (with home-manager
as a module). Exept i only finished waylander for now, druss, wsl and min will
follow.

TODO :

- [x] programming languages in nix shells
- [ ] rewrite an modularize the whole config
  - [x] waylander
  - [ ] druss
  - [ ] delnoch
  - [ ] wsl
  - [x] min
- [ ] ajouter une config nvf minimaliste

```
.
├── flake.lock
├── flake.nix
├── hosts
│   ├── druss (WIP)
│   └── waylander
│       ├── default.nix
│       ├── hardware.nix
│       ├── kanata.nix
│       ├── security.nix
│       └── swap.nix
├── modules
│   ├── HM
│   │   ├── default.nix
│   │   ├── env.nix
│   │   ├── font.nix
│   │   ├── gaming.nix
│   │   ├── git.nix
│   │   ├── home.nix
│   │   ├── hypr
│   │   │   ├── default.nix
│   │   │   ├── hyprland.nix
│   │   │   └── packages.nix
│   │   ├── keyboard.nix
│   │   ├── packages.nix
│   │   ├── shell
│   │   │   ├── default.nix
│   │   │   ├── fish.nix
│   │   │   ├── starship.nix
│   │   │   └── zoxide.nix
│   │   └── zen.nix
│   └── nixos
│       ├── amd-drivers.nix
│       ├── boot.nix
│       ├── default.nix
│       ├── flatpak.nix
│       ├── gaming.nix
│       ├── keyboard.nix
│       ├── locale.nix
│       ├── local-hardware-clock.nix
│       ├── login.nix
│       ├── network.nix
│       ├── nix.nix
│       ├── systemVersion.nix
│       ├── time.nix
│       ├── user.nix
│       └── wayland.nix
├── nvf.nix
├── README.md
├── shells.nix
└── tmp

9 directories, 49 files
```
