{ config, ... }: let
  cfg = config.hardware.time;
in {
  time = {
    inherit (cfg) timeZone;
    hardwareClockInLocalTime = true;
  };
}
