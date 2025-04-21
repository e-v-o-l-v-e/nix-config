{username, ...}: {
  programs.git = {
    enable = true;
    userName = username;
    userEmail = "elivanoa5@gmail.com";
    extraConfig = {
      autoSetupRemote = true;
    };
  };
}
