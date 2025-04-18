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
│   ├── HM
│   │   ├── code.nix
│   │   ├── common.nix
│   │   ├── default.nix
│   │   ├── delnoch.nix
│   │   ├── druss.nix
│   │   ├── home.nix
│   │   └── waylander.nix
│   └── nixos
│       ├── amd-drivers.nix
│       ├── default.nix
│       ├── local-hardware-clock.nix
│       └── vm-guest-services.nix
├── nvf.nix
├── README.md
└── shells.nix

8 directories, 29 files
```
