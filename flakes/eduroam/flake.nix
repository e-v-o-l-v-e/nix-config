{
  description = "Install eduroam on NixOS systems";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # The Eduroam Python script for the University of Strasbourg
    eduroam-university-strasbourg = {
      url = "https://cat.eduroam.org/user/API.php?action=downloadInstaller&lang=en&profile=328&device=linux&generatedfor=user&openroaming=0";
      flake = false;
    };

    # The Eduroam Python script for the University of Bonn
    eduroam-university-bonn = {
      url = "https://cat.eduroam.org/user/API.php?action=downloadInstaller&lang=en&profile=5133&device=linux&generatedfor=user&openroaming=0";
      flake = false;
    };

    # The Eduroam Python script for the University of Cologne
    eduroam-university-koeln = {
      url = "https://cat.eduroam.org/user/API.php?action=downloadInstaller&lang=en&profile=5133&device=linux&generatedfor=user&openroaming=0";
      flake = false;
    };

    # The Eduroam Python script for Lund University
    eduroam-lund-university = {
      url = "https://cat.eduroam.org/user/API.php?action=downloadInstaller&lang=en&profile=1338&device=linux&generatedfor=user&openroaming=0";
      flake = false;
    };

    # The Eduroam Python script for the University of Siegen
    eduroam-university-siegen = {
      url = "https://cat.eduroam.org/user/API.php?action=downloadInstaller&lang=en&profile=5356&device=linux&generatedfor=user&openroaming=0";
      flake = false;
    };

    # The Eduroam Python script for Saarland University
    eduroam-saarland-university = {
      url = "https://cat.eduroam.org/user/API.php?action=downloadInstaller&lang=en&profile=10315&device=linux&generatedfor=user&openroaming=0";
      flake = false;
    };
  };

  outputs = { self, ... }@inputs:
    with inputs;
    let
      supportedSystems = [ "aarch64-linux" "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; overlays = [ ]; });
    in
    {
      formatter = forAllSystems (system: nixpkgsFor.${system}.nixpkgs-fmt);
      packages = forAllSystems (system:
        let
          pkgs = nixpkgsFor.${system};
          python-with-dbus = pkgs.python3.withPackages (p: with p; [ dbus-python ]);
        in
        {
          # nix run .#list-eduroam-entityIDs
          list-eduroam-entityIDs = pkgs.writeShellScriptBin "list-eduroam-entityIDs"
            "${pkgs.curl}/bin/curl 'https://cat.eduroam.org/user/API.php?action=listAllIdentityProviders&api' | ${pkgs.jq}/bin/jq";

          # nix run .#install-eduroam-university-strasbourg
          strasbourg = pkgs.writeShellScriptBin "install-eduroam-university-strasbourg"
            "${python-with-dbus}/bin/python3 ${eduroam-university-strasbourg}";

          # nix run .#install-eduroam-university-bonn
          install-eduroam-university-bonn = pkgs.writeShellScriptBin "install-eduroam-university-bonn"
            "${python-with-dbus}/bin/python3 ${eduroam-university-bonn}";

          # nix run .#install-eduroam-university-koeln
          install-eduroam-university-koeln = pkgs.writeShellScriptBin "install-eduroam-university-koeln"
            "${python-with-dbus}/bin/python3 ${eduroam-university-koeln}";

          # nix run .#install-eduroam-lund-university
          install-eduroam-lund-university = pkgs.writeShellScriptBin "install-eduroam-university-lund"
            "${python-with-dbus}/bin/python3 ${eduroam-lund-university}";

          # nix run .#install-eduroam-university-siegen
          install-eduroam-university-siegen = pkgs.writeShellScriptBin "install-eduroam-university-siegen"
            "${python-with-dbus}/bin/python3 ${eduroam-university-siegen}";

          # nix run .#install-eduroam-saarland-university
          install-eduroam-saarland-university = pkgs.writeShellScriptBin "install-eduroam-saarland-university"
            "${python-with-dbus}/bin/python3 ${eduroam-saarland-university}";
        });
    };
}
