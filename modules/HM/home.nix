{username, ...}: {
  home = {
    username = username;
    homeDirectory = "/home/${username}";
  };
}
