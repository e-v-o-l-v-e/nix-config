{lib, ...}: {
  defaults = {
    server = lib.mkDefault false;
    wsl = lib.mkDefault false;
    gaming = lib.mkDefault "none";
    DE = lib.mkDefault [];
    useZen = lib.mkDefault false;
    personal = lib.mkDefault true;
    gpu = lib.mkDefault "";
  };

  waylander = {
    personal = true;
    useZen = true;
    gaming = "simple";
    DE = ["hyprland"];
    server = false;
    login = "greetd";
    gpu = "amd";
  };

  druss = {
    personal = true;
    useZen = true;
    gaming = "full";
    DE = ["plasma" "hyprland"];
    login = "sddm";
    server = false;
    gpu = "amd";
  };

  wsl = {
    personal = false;
    useZen = false;
    gaming = "none";
    DE = [];
    server = false;
    wsl = true;
  };

  delnoch = {
    personal = false;
    useZen = false;
    gaming = "none";
    DE = [];
    server = true;
  };
}
