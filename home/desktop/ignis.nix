{ inputs, pkgs, ...}: {
  imports = [ inputs.ignis.homeManagerModules.default ];

  programs.ignis = {
    enable = true;

    services = {
      bluetooth.enable = true;
      recorder.enable = true;
      audio.enable = true;
      network.enable = true;
    };

    extraPackages = with pkgs; [
      python313Packages.pillow
      python313Packages.numpy
      imagemagick
      tesseract
      python313Packages.sklearn-compat
    ];
  };
}
