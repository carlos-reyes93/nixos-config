{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-nvim.url = "github:carlos-reyes93/nix-nvim";
  };

  outputs = {
    self,
    nixpkgs,
    nixos-wsl,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${system};
    nixosHostSettings = import ./profiles/nixos.nix;
    weaselHostSettings = import ./profiles/weasel.nix.nix;
  in {
    nixosConfigurations = {
      weasel = lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit weaselHostSettings;
        };
        inherit system;
        modules = [
          nixos-wsl.nixosModules.default
          ./hosts/weasel/default.nix
        ];
      };
      nixos = lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit nixosHostSettings;
        };
        inherit system;
        modules = [
          ./hosts/nixos/default.nix
        ];
      };
    };
    homeConfigurations = {
      "charly@weasel" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit weaselHostSettings;
        };
        modules = [
          ./modules/home-manager/fetch-mutable-files.nix
          ./hosts/weasel/home.nix
        ];
      };
      "charly@nixos" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit nixosHostSettings;
        };
        modules = [
          ./modules/home-manager/fetch-mutable-files.nix
          ./hosts/nixos/home.nix
        ];
      };
    };
  };
}
