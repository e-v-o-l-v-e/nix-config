{ hostConfig, ... }: let
  cfg = hostConfig.hardware.time;
in {
  time = {
    inherit (cfg) timeZone;
    hardwareClockInLocalTime = true;
  };
}
