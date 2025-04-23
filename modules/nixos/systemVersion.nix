{hostname, ...}: let
  sysv = {
    waylander = "24.11";
    wsl = "24.11";
    druss = "24.11";
  };
in {
  system.stateVersion = sysv.${hostname} or "24.11";
}
