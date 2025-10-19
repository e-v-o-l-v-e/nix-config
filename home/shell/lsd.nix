_: {
  programs.lsd = {
    enable = true;
    enableFishIntegration = false;

    settings = { 
      date = "date"; 

      blocks = [
        "permission"
        "user"
        "group"
        "size"
        "links"
        "date"
        "name"
      ];

      ignore-globs = [
        ".git"
      ];
    };
  };
}
