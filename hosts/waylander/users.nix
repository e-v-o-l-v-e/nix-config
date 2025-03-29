# 💫 https://github.com/JaKooLit 💫 #
# Users - NOTE: Packages defined on this will be on current user only

{ pkgs, username, ... }:

let
    inherit (import ./variables.nix) gitUsername;
in
    {
    users = { 
        mutableUsers = true;
        users."${username}" = {
            homeMode = "755";
            isNormalUser = true;
            description = "evolve";
            extraGroups = [
                "networkmanager"
                "wheel"
                "libvirtd"
                "scanner"
                "lp"
                "video" 
                "input" 
                "audio"
                "kvm"
                "inputs"
                "uinputs"
            ];

            # define user packages here
            packages = with pkgs; [
                element-desktop
                fishPlugins.tide
                libreoffice-qt6-fresh
                libsForQt5.kdeconnect-kde
                localsend
                nextcloud-client
                remmina
                steam
                supersonic
                vesktop

                # code
                jdk
                jdt-language-server
                jre
                lua-language-server
                vimPlugins.nvim-jdtls
            ];
        };

        defaultUserShell = pkgs.fish;
    }; 

    environment.shells = with pkgs; [ fish ];
    environment.systemPackages = with pkgs; [ lsd fzf ]; 

    programs = {
        fish = {
            enable = true;
        };

        # Zsh configuration
        zsh = {
            enable = true;
            enableCompletion = true;
            ohMyZsh = {
                enable = true;
                plugins = ["git"];
                theme = "agnoster"; 
            };

            autosuggestions.enable = true;
            syntaxHighlighting.enable = true;

            promptInit = ''
        fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc

        #pokemon colorscripts like. Make sure to install krabby package
        #krabby random --no-mega --no-gmax --no-regional --no-title -s; 

        # Set-up icons for files/folders in terminal using lsd
        alias ls='lsd'
        alias l='ls -l'
        alias la='ls -a'
        alias lla='ls -la'
        alias lt='ls --tree'

        source <(fzf --zsh);
        HISTFILE=~/.zsh_history;
        HISTSIZE=10000;
        SAVEHIST=10000;
        setopt appendhistory;
            '';
        };
    };
}
