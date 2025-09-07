{ username, pkgs, ... }:{
  programs.gh = {
    enable = true;

    settings = {
      editor = "nvim";      

      git_protocol = "ssh";
    
      prompt = "enabled";
    
      aliases = {
        co = "pr checkout";
        pv = "pr view";
      };
    };

    # hosts = { 
    #   "github.com" = {
    #     inherit username;
    #     git_protocol = "ssh";
    #   };
    # };

    extensions = with pkgs; [ 
      gh-eco
      gh-markdown-preview
      gh-f
      gh-s
      gh-cal
      gh-screensaver
      gh-notify
    ];
  };

  programs.gh-dash.enable = true;
}
