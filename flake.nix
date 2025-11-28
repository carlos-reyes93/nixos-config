{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-wsl,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        weasel = lib.nixosSystem {
          specialArgs = { inherit inputs; };
          inherit system;
          modules = [
            nixos-wsl.nixosModules.default
            ./hosts/weasel/default.nix
          ];
        };
      };
      homeConfigurations = {
        charly = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./modules/home-manager/fetch-mutable-files.nix
            ./modules/home-manager/home.nix
          ];
        };
      };
    };
}
