{ lib, ... }:
{
  defaults = {
    DE = lib.mkDefault [ ];
    gaming = lib.mkDefault "none";
    gpu = lib.mkDefault "";
    login = lib.mkDefault "";
    nvfConfig = lib.mkDefault "nvf-min";
    personal = lib.mkDefault true;
    server = lib.mkDefault false;
    useAppImage = lib.mkDefault false;
    useZen = lib.mkDefault false;
    wsl = lib.mkDefault false;
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
