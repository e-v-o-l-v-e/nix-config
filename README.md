# My Flake

# WIP, README NOT UP TO DATE

This flake holds the config (nixos and/or home-manager) for all my machines.

## HOSTS

- waylander : laptop config
- druss : battle station
- delnoch : server, only host still not on Nixos, HM on Debian

All configs are intended for nixos with home-manager as a module, it will be available for just home-manager soon.

Options are declared in ./options.nix, and set by host in ./hosts/{hostname}/configuration.nix, the code is either clear or commented, take a look at the options, it's of course opinionated.

## Structure

```shell
nix-config/
├── flake.lock
├── flake.nix
├── home/
│   ├── apps/
│   │   ├── default.nix
│   │   ├── gaming.nix
│   │   ├── kitty.nix
│   │   ├── packages.nix
│   │   └── zen.nix
│   ├── default.nix
│   ├── desktop/
│   │   ├── default.nix
│   │   ├── fonts.nix
│   │   ├── hypr/
│   │   │   ├── default.nix
│   │   │   ├── hyprland.nix
│   │   │   ├── packages.nix
│   │   │   └── waybar.nix
│   │   ├── quickshell/
│   │   └── stylix.nix
│   ├── home.nix
│   ├── nvf.nix
│   └── shell/
│       ├── default.nix
│       ├── fish.nix
│       ├── git.nix
│       ├── packages.nix
│       ├── pay-respects.nix
│       ├── starship.nix
│       ├── tmux.nix
│       ├── zellij.nix
│       └── zoxide.nix
├── hosts/
│   ├── druss/
│   │   ├── configuration.nix
│   │   ├── default.nix
│   │   ├── hardware.nix
│   └── waylander/
│       ├── configuration.nix
│       ├── default.nix
│       └── hardware.nix
├── options.nix
├── README.md
├── shells.nix
└── system/
    ├── default.nix
    ├── desktop/
    │   ├── default.nix
    │   ├── fonts.nix
    │   ├── gaming.nix
    │   ├── login.nix
    │   ├── stylix.nix
    │   └── wayland.nix
    ├── hardware/
    │   ├── amd-drivers.nix
    │   ├── boot.nix
    │   ├── default.nix
    │   ├── keyboard.nix
    │   ├── openrgb.nix
    │   └── time.nix
    ├── laptop.nix
    ├── locale.nix
    ├── network.nix
    ├── nix.nix
    └── user.nix
```


## Reference

- NVF : neovim config nix wrapper or something, it's really cool [github](https://github.com/NotAShelf/nvf), [manual](https://notashelf.github.io/nvf/index.xhtml).
- [zen-browser](https://zen-browser.app) : really cool browser based on firefox by [github](https://github.com/zen-browser/desktop), [site](https://zen-browser.app). 
- initial hyprland config : [JaKooLit's hyprland dotfiles](https://github.com/JaKooLit/Hyprland-Dots), i still lose some of this, i will soon write my hyprland config in nix
- hyprland, https://hypr.land
- initial nixos config : [JaKooLit's nixos config](https://github.com/JaKooLit/NixOS-Hyprland/tree/main), there's barely anything left from it, but it's a nice starting point, no home manager though


