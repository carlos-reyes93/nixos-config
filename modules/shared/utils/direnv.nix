{
  config,
  lib,
  ...
}: {
  config = lib.mkMerge [
    {
      home-manager.users.${config.charly.user.name} = {
        programs.direnv = {
          enable = true;
          nix-direnv.enable = true;
        };
      };
    }
  ];
}
