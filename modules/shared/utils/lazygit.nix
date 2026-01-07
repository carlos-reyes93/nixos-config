{
  config,
  lib,
  ...
}: {
  config = lib.mkMerge [
    {
      home-manager.users.${config.charly.user.name} = {
        programs.lazygit = {
          enable = true;
          settings = {
            commit = {
              signOff = true;
            };
          };
        };
      };
    }
  ];
}
