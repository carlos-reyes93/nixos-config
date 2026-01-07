{
  config,
  inputs,
  lib,
  ...
}: let
  user = config.charly.user.name;
  flavor = config.charly.colorScheme.flavor;
  accent = config.charly.colorScheme.accent;
in {
  config = lib.mkMerge [
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
        users = {
          "${user}" = {...}: {
            imports = [
              inputs.catppuccin.homeModules.catppuccin
              inputs.nix-colors.homeManagerModules.default
            ];

            colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

            home = {
              stateVersion = config.charly.homeStateVersion;
              username = config.charly.user.name;
              homeDirectory = config.charly.user.homeDirectory;
              sessionVariables = {};
            };

            catppuccin = {
              enable = true;
              flavor = flavor;
              accent = accent;
            };
          };
        };
      };
    }
  ];
}
