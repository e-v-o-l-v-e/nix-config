{ config, ... }: let
  cfg = config.hardware;
in {
  time = {
    inherit (cfg) timeZone;
    hardwareClockInLocalTime = true;
  };
}
