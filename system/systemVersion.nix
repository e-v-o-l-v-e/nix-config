{hostname, ...}: let
  sysv = {
    waylander = "24.11";
    wsl = "24.11";
    druss = "25.05";
  };
in {
  system.stateVersion = sysv.${hostname} or "25.05";
}
