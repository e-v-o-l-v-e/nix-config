_: {
  programs.lsd = {
    enable = true;
    enableFishIntegration = true;

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
