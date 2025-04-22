{hostname, ...}: {
  programs.steam.enable = hostname == "waylander" || hostname == "druss";
}
