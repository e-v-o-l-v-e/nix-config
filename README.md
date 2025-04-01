# My Flake

TODO :
- mv les flakes en shells
- faire une vraie config pour druss
- faire la config pour delnoch
- ajouter une config nvf minimaliste

```
nix-config/
├── flake.lock
├── flake.nix
├── flakes
├── hosts
│   ├── default
│   │   ├── config.nix
│   │   ├── packages-fonts.nix
│   │   ├── users.nix
│   │   └── variables.nix
│   ├── druss
│   │   └── home.nix
│   └── waylander
│       ├── config.nix
│       ├── hardware.nix
│       ├── packages-fonts.nix
│       ├── users.nix
│       └── variables.nix
└── modules
    ├── amd-drivers.nix
    ├── local-hardware-clock.nix
    ├── nvf.nix
    └── vm-guest-services.nix

```
