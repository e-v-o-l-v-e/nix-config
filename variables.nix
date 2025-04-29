{ lib, ... }:
{
  defaults = {
    server = lib.mkDefault false;
    wsl = lib.mkDefault false;
    gaming = lib.mkDefault "none";
    DE = lib.mkDefault [ ];
    useZen = lib.mkDefault false;
    personal = lib.mkDefault true;
    gpu = lib.mkDefault "";
    useAppImage = lib.mkDefault false;
    nvfConfig = lib.mkDefault "nvf-min";
    login = lib.mkDefault "";
  };

  waylander = {
    personal = true;
    useZen = true;
    gaming = "simple";
    DE = [ "hyprland" ];
    server = false;
    login = "greetd";
    gpu = "amd";
    useAppImage = true;
    nvfConfig = "nvf-max";
  };

  druss = {
    personal = true;
    useZen = true;
    gaming = "full";
    DE = [
      "plasma"
      "hyprland"
    ];
    login = "sddm";
    server = false;
    gpu = "amd";
    useAppImage = true;
    nvfConfig = "nvf-max";
  };

  wsl = {
    personal = false;
    useZen = false;
    gaming = "none";
    DE = [ ];
    server = false;
    wsl = true;
    nvfConfig = "nvf-max";
  };

  delnoch = {
    personal = false;
    useZen = false;
    gaming = "none";
    DE = [ ];
    server = true;
    nvfConfig = "nvf-max";
  };

  min = {
    personal = false;
    useZen = true;
    gaming = "none";
    DE = [ "hyprland" ];
    login = "greetd";
    server = false;
    useAppImage = false;
    nvfConfig = "nvf-min";
  };
}
