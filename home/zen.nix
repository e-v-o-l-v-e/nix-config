{
  inputs,
  personal,
  zen-browser,
  ...
}:
{
  # imports = [ zen-browser.homeModules.twilight ];

  programs.zen-browser.enable = personal;
}
