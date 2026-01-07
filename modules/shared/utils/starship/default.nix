{
  config,
  lib,
  ...
}: {
  config = lib.mkMerge [
    {
      home-manager.users.${config.charly.user.name} = {
        programs.starship = {
          enable = true;
          enableFishIntegration = true;
          settings = builtins.fromTOML (builtins.readFile ./starship.toml);
        };
      };
    }
  ];
}
