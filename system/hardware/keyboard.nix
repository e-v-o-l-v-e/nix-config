{config, ...}: 
let
  cfg = config.hardware.keyboard;
in {
  console.keyMap = "uk";

  services.xserver = {
    enable = true;
    xkb = {
      inherit (cfg) layout variant;
    };
  };

  services.kanata = {
    inherit (cfg.kanata) enable;
    keyboards = {
      internalKeyboard = {
        devices = [
          "/dev/input/event1"
          "/dev/input/event4"
        ];
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
          (deflocalkeys-linux
            conf 171
          )
          (defsrc
             caps esc a s d f j k l ;
            conf
          )
          (defvar
             tap-time 149
             hold-time 150
             long-tap-time 200
             long-hold-time 200
          )

          (defalias
             escctrl (tap-hold 200 200 esc lctl)
             a (tap-hold $long-tap-time $long-hold-time a lalt)
             s (tap-hold $tap-time $long-hold-time s lmet)
             d (tap-hold $tap-time $hold-time d lsft)
             f (tap-hold $tap-time $hold-time f lctl)
             j (tap-hold $tap-time $hold-time j rctl)
             k (tap-hold $tap-time $hold-time k rsft)
             l (tap-hold $tap-time $hold-time l rmet)
             ; (tap-hold $long-tap-time $long-hold-time ; ralt)
             base (layer-switch base)
             game (layer-switch game)
             cec (layer-switch cec)
          )

          (deflayer base
             @escctrl caps @a @s @d @f @j @k @l @;
             @game
          )
          (deflayer game
             @escctrl caps a s d f @j @k @l @;
             @cec
          )
          (deflayermap cec
             caps @escctrl
             esc caps
             conf @base
          )
        '';
      };
    };
  };
}
