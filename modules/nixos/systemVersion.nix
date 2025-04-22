{hostname, ...}: let
  sysv = {
    waylander = "24.11";
  };
in {
  system.stateVersion = sysv."${hostname}" or "";
}
