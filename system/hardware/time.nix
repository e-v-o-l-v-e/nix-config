{ config, lib, ... }:
{
  config.time = {
    inherit (config) timeZone;
    hardwareClockInLocalTime = true;
  };

  option.timeZone = lib.mkOption {
    type = lib.types.str;
    default = "Europe/Paris";
  };
}
