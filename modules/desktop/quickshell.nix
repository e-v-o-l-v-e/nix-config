{
  flake.modules.homeManager.quickshell =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.quickshell ];
    };
}
