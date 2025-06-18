{ hostConfig, ... }:
let
  # my locale setup is weird
  # i have almost everything in french but my default and numeric are english
  # i need to learn how all this really works one day
  en = "en_GB.UTF-8";
  fr = "fr_FR.UTF-8";
in
{
  i18n.defaultLocale = en;

  i18n.extraLocaleSettings = {
    LC_TIME = fr;
    LC_ADDRESS = fr;
    LC_IDENTIFICATION = fr;
    LC_MEASUREMENT = fr;
    LC_MONETARY = fr;
    LC_NAME = fr;
    LC_NUMERIC = en;
    LC_PAPER = fr;
    LC_TELEPHONE = fr;
  };
}
