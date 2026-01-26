{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-nvim.url = "github:carlos-reyes93/nix-nvim";
    hyprland.url = "github:hyprwm/Hyprland";
    matugen.url = "github:InioX/Matugen";
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    apple-fonts.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hyprlang.follows = "hyprland/hyprlang";
    };
    nix-colors = {
      url = "github:misterio77/nix-colors";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixos-wsl,
    home-manager,
    catppuccin,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = system:
      nixpkgs.lib.recursiveUpdate (import ./lib {
        pkgs = nixpkgs.legacyPackages.${system};
        lib = nixpkgs.lib;
      })
      nixpkgs.lib;
    sharedModules = [
      ./modules/shared
    ];
    nixosModules = [
      home-manager.nixosModules.home-manager
      catppuccin.nixosModules.catppuccin
      nixos-wsl.nixosModules.default
    ];
    desktopModules = [./modules/nixos];
  in {
    nixosConfigurations = {
      weasel =
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
            lib = lib "x86_64-linux";
          };
          modules = sharedModules ++ nixosModules ++ [./machines/weasel/default.nix];
        };
      mamalona = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
          lib = lib "x86_64-linux";
        };
        modules = sharedModules ++ nixosModules ++ desktopModules ++ [./machines/mamalona/default.nix];
      };
    };
  };
}
