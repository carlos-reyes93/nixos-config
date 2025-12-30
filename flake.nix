{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-nvim.url = "github:carlos-reyes93/nix-nvim";
    hyprland.url = "github:hyprwm/Hyprland";
    matugen.url = "github:InioX/Matugen";
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    apple-fonts.inputs.nixpkgs.follows = "nixpkgs";
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hyprlang.follows = "hyprland/hyprlang";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixos-wsl,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      weasel = lib.nixosSystem {
        specialArgs = {
          inherit inputs;
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
        };
        inherit system;
        modules = [
          ./hosts/nixos/default.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.charly = import ./hosts/nixos/home.nix;
            home-manager.backupFileExtension = "bak";
            home-manager.sharedModules = [
              ./modules/home-manager/fetch-mutable-files.nix
            ];
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
          }
        ];
      };
    };
    homeConfigurations = {
      "charly@weasel" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./modules/home-manager/fetch-mutable-files.nix
          ./hosts/weasel/home.nix
        ];
      };
      # "charly@nixos" = home-manager.lib.homeManagerConfiguration {
      #   inherit pkgs;
      #   extraSpecialArgs = {
      #     inherit inputs;
      #   };
      #   modules = [
      #     ./modules/home-manager/fetch-mutable-files.nix
      #     ./hosts/nixos/home.nix
      #   ];
      # };
    };
  };
}
