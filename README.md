# My Flake

This flake holds the config (nixos and/or home-manager) for all my machines.

> [!Warning]
> WIP, up to date as of august 13

> [!Note] Note (november 19)
> I moved my dotfiles outside of nix : https://github.com/e-v-o-l-v-e/dotfiles

## CONFIG

This config is VERY opinionated, for example i use fish and don't support other
shells, because fish is awesome, so all scripts are in fish.

Basic configuration (enable this and that) happens in ./hosts/{hostname}/configuration.nix,
there is no (i think, or it's relative) enabling in home or system dir, to make
it simple to use such or such thing, i don't know where I'm going I'll come back
and make this readme better sometime, don't hesitate to open issue or discussion
if you need help for something, I'll gladly make myself useful.

Options are declared in ./options.nix for global ones, or in the relevant files,
and set by host in  the code is either
clear or commented, take a look at the options, it's of course opinionated.

To create your own config just copy one of /hosts/${hostname} and edit from there.

## HOSTS

My hostnames are characters or places from David Gemmel's Drenai saga.

- waylander : laptop config
- druss : battle station
- delnoch : server, only host still not on Nixos, HM on Debian, I'm configuring
everything for nixos, replacing docker with services before installing

All configs are intended for nixos with home-manager standalone, or just
home-manager on any linux distribution.

## Theming

Each themed app has a fish script in its nix file to switch its theme, it also
have a fish script to init its parameters.
All switch/init scripts are called by a global switch/init script declared in 
home/desktop/theme.nix

### todo

Main

- [x] kitty
- [x] nvim
- [ ] btop
- [x] gtk
- [x] plasma
- [ ] hyprland

Optional specific theming

- [ ] vesktop
- [ ] qt ?

## Structure

```shell
.
├── flake.lock
├── flake.nix
├── options.nix
├── README.md
├── custom/
│   ├── shells.nix
│   ├── modules/
│   │   └── local-content-share.nix
│   └── overlays/
│       └── caddy-cloudflare.nix
├── home/
│   ├── home.nix
│   ├── default.nix
│   ├── nvf.nix
│   ├── apps/
│   │   ├── default.nix
│   │   ├── gaming.nix
│   │   ├── kitty.nix
│   │   └── packages.nix
│   ├── desktop/
│   │   ├── default.nix
│   │   ├── fonts.nix
│   │   ├── hypr.nix
│   │   └── theme.nix
│   └── shell/
│       ├── default.nix
│       ├── btop.nix
│       ├── fish.nix
│       ├── git.nix
│       ├── packages.nix
│       ├── pay-respects.nix
│       ├── ssh.nix
│       ├── starship.nix
│       ├── tmux.nix
│       ├── zellij.nix
│       └── zoxide.nix
├── hosts/
│   ├── delnoch/
│   │   ├── configuration.nix
│   │   └── default.nix
│   ├── druss/
│   │   ├── configuration.nix
│   │   ├── default.nix
│   │   └── hardware.nix
│   └── waylander/
│       ├── configuration.nix
│       ├── default.nix
│       └── hardware.nix
├── secrets/
│   ├── common.yaml
│   ├── delnoch.yaml
│   ├── druss.yaml
│   ├── server.yaml
│   ├── waylander.yaml
│   └── public_keys/
│       ├── github.pub
│       └── git_unistra.pub
└── system/
    ├── default.nix
    ├── docker.nix
    ├── laptop.nix
    ├── locale.nix
    ├── network.nix
    ├── nix.nix
    ├── server.nix
    ├── sops.nix
    ├── user.nix
    ├── desktop/
    │   ├── default.nix
    │   ├── fonts.nix
    │   ├── gaming.nix
    │   ├── login.nix
    │   └── wayland.nix
    ├── hardware/
    │   ├── default.nix
    │   ├── amd-drivers.nix
    │   ├── boot.nix
    │   ├── keyboard.nix
    │   ├── openrgb.nix
    │   └── time.nix
    └── services/
        ├── default.nix
        ├── arr.nix
        ├── caddy.nix
        ├── copyparty.nix
        ├── jellyfin.nix
        ├── jellyseerr.nix
        ├── local-content-share.nix
        ├── opencloud.nix
        ├── qbittorrent.nix
        └── silverbullet.nix

20 directories, 77 files
```

## Reference

- NVF : neovim config nix wrapper or something, it's really cool [github](https://github.com/NotAShelf/nvf), [manual](https://notashelf.github.io/nvf/index.xhtml).
- [zen-browser](https://zen-browser.app) : really cool browser based on firefox by [github](https://github.com/zen-browser/desktop)
- initial nixos config : [JaKooLit's nixos config](https://github.com/JaKooLit/NixOS-Hyprland/tree/main), nothing left from it

