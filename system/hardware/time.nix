{ config, lib, ... }:
{
  config.time = {
    inherit (config) timeZone;
    hardwareClockInLocalTime = true;
  };

  options.timeZone = lib.mkOption {
    type = lib.types.str;
    default = "Europe/Paris";
  };
}
