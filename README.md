# My Flake

modular config.

HOST :

- delnoch : server, cli and shell, docker
- min : minimal, server without server specific
- waylander : laptop config
- druss : battlestation, maximal config

TODO :

- [x] programming languages in nix shells
- [ ] rewrite an modularize the whole config
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
│   └── waylander
│       ├── configuration.nix /td
│       ├── default.nix
│       ├── hardware.nix
│       ├── home.nix /td
│       ├── kanata.nix
│       ├── packages-fonts.nix /td
│       ├── users.nix /td
│       └── variables.nix /td
├── modules
│   ├── HM
│   │   ├── default.nix
│   │   ├── env.nix
│   │   ├── fish.nix
│   │   ├── gaming.nix
│   │   ├── home.nix
│   │   └── packages.nix
│   └── nixos
│       ├── amd-drivers.nix
│       ├── default.nix
│       ├── local-hardware-clock.nix
│       └── vm-guest-services.nix
├── nvf.nix
├── README.md
└── shells.nix

7 directories, 27 files
```
