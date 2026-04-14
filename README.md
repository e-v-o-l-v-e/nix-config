# My Flake

This flake holds the config (nixos and/or home-manager) for all my machines.
It uses [flake parts](https://flake.parts/) and the [dendritic pattern](https://github.com/mightyiam/dendritic), if you're interested i strongly recommend this guide : https://github.com/Doc-Steve/dendritic-design-with-flake-parts

> [!Note] 
> (november 19)
> I moved my dotfiles outside of nix : https://github.com/e-v-o-l-v-e/dotfiles

> [!NOTE]
> If you're interested in my old, non flake-part, config it's on the [old](https://github.com/e-v-o-l-v-e/nix-config/tree/old) branch, though now unmaintained

## CONFIG

This config is VERY opinionated, for example i use fish and don't support other shells, because fish is awesome, so all scripts are in fish.

Basic configuration host configuration (import this or that) happens in ./modules/hosts/{hostname}/configuration.nix.

it simple to use such or such thing, i don't know where I'm going I'll come back
and make this readme better sometime, don't hesitate to open issue or discussion
if you need help for something, I'll gladly make myself useful.

To create your own config just copy one of ./modules/hosts/${hostname} and go from there.

## HOSTS

My hostnames are characters or locations from David Gemmel's Drenai saga.

- waylander : laptop
- druss : desktop
- delnoch : server
- simple / mini, temp HM config, currently used on my debian vps

Any nixos module can be used any nixos config, same for home-manager.


## Theming

see [my dotfiles](https://github.com/e-v-o-l-v-e/dotfiles)

### todo

use this banger : https://github.com/BirdeeHub/nix-wrapper-modules
maybe move back at least part of my dotfiles to nix

## Structure

```shell
./
├── flake.lock
├── flake.nix
├── modules/
│   ├── desktop/
│   │   ├── apps.nix
│   │   ├── fonts.nix
│   │   ├── hyprland.nix
│   │   └── plasma.nix
│   ├── hosts/
│   │   ├── defaults.nix
│   │   ├── delnoch/
│   │   │   ├── configuration.nix
│   │   │   ├── hardware.nix
│   │   │   └── sops.nix
│   │   ├── druss/
│   │   │   ├── configuration.nix
│   │   │   ├── hardware.nix
│   │   │   └── sops.nix
│   │   ├── mini/
│   │   │   └── home.nix
│   │   ├── simple/
│   │   │   └── home.nix
│   │   └── waylander/
│   │       ├── configuration.nix
│   │       ├── hardware.nix
│   │       └── sops.nix
│   ├── nix/
│   │   ├── flake-parts/
│   │   │   ├── flake-parts.nix
│   │   │   └── lib.nix
│   │   ├── nix.nix
│   │   ├── shells.nix
│   │   ├── _templates/
│   │   │   ├── mini/
│   │   │   │   └── flake.nix
│   │   │   └── web-bun-express-prisma/
│   │   │       └── flake.nix
│   │   └── templates.nix
│   ├── preferences.nix
│   ├── programs/
│   │   ├── appimage.nix
│   │   ├── cli/
│   │   │   ├── apps.nix
│   │   │   ├── direnv.nix
│   │   │   ├── fish.nix
│   │   │   ├── gh.nix
│   │   │   ├── git.nix
│   │   │   ├── lsd.nix
│   │   │   ├── nix-index.nix
│   │   │   ├── pay-respects.nix
│   │   │   ├── starship.nix
│   │   │   ├── tmux.nix
│   │   │   ├── zk.nix
│   │   │   └── zoxide.nix
│   │   ├── gaming.nix
│   │   ├── kanata.nix
│   │   ├── neovim.nix
│   │   ├── nh.nix
│   │   ├── sops.nix
│   │   ├── ssh.nix
│   │   └── zen-browser.nix
│   ├── services/
│   │   └── server services (jellyfin, opencloud etc)
│   ├── system/
│   │   ├── boot/
│   │   │   └── systemd-boot.nix
│   │   ├── gpu-amd.nix
│   │   ├── kernel.nix
│   │   ├── keyboard.nix
│   │   ├── locales.nix
│   │   ├── login-managers/
│   │   │   ├── greetd.nix
│   │   │   └── sddm.nix
│   │   ├── network/
│   │   │   ├── avahi.nix
│   │   │   ├── bluetooth.nix
│   │   │   ├── net.nix
│   │   │   ├── printing.nix
│   │   │   └── tailscale.nix
│   │   ├── plymouth.nix
│   │   ├── time.nix
│   │   └── wayland.nix
│   └── users/
│       └── evolve.nix
├── README.md
└── secrets/
```
