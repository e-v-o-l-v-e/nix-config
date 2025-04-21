{
  inputs,
  hostname,
  ...
}: {
  imports = [inputs.zen-browser.homeModules.twilight];

  programs.zen-browser = {
    enable = hostname != "delnoch";
  };
}
