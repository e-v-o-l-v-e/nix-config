{
  description = "python shell";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/24.11";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
	nativeBuildInputs = with pkgs; [
	  python3
	  python3Packages.pip
          python312Packages.pandas
          python312Packages.numpy
          python312Packages.matplotlib
	];

	shellHook = ''
          export SHELL=${pkgs.fish}/bin/fish
          # fish -c "
          #   if not [ -e ./python-venv/bin/activate.fish ];
          #     python -m venv ./python-venv
          #   end
          #   source ./python-venv/bin/activate.fish
          #   pip install numpy
          #   pip install pandas
          #   pip install matplotlib
          #   echo 'Installed packages:'
          #   pip list
          # "
          # source ./python-venv/bin/activate
          fish
          exit
	'';
      };
    };
}
