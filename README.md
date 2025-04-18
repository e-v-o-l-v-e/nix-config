# My Flake

TODO :

- [x] mv les flakes en shells
- [ ] faire la config pour delnoch
  - [ ] home-manager
  - [ ] nixos
- [ ] faire une vraie config pour druss
  - [ ] home-manager
  - [ ] nixos
- [ ] (optionel)ajouter une config nvf minimaliste

```
.
├── flake.lock
├── flake.nix
├── flakes
│   └── eduroam
│       ├── flake.lock
│       ├── flake.nix
│       └── README.md
├── hosts
│   ├── druss
│   │   ├── config.nix
│   │   ├── packages-fonts.nix
│   │   ├── users.nix
│   │   └── variables.nix
│   ├── shared
│   │   └── common.nix
│   └── waylander
│       ├── configuration.nix
│       ├── default.nix
│       ├── hardware.nix
│       ├── home.nix
│       ├── kanata.nix
│       ├── packages-fonts.nix
│       ├── users.nix
│       └── variables.nix
├── modules
│   ├── code.nix
│   ├── hardware
│   │   ├── amd-drivers.nix
│   │   ├── default.nix
│   │   ├── local-hardware-clock.nix
│   │   └── vm-guest-services.nix
│   ├── HM
│   │   ├── common.nix
│   │   ├── delnoch.nix
│   │   ├── druss.nix
│   │   └── waylander.nix
│   └── nvf.nix
├── README.md
└── shells.nix

10 directories, 30 files
```
