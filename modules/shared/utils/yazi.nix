{config, ...}: {
  config = {
    home-manager.users.${config.charly.user.name} = {
      programs.yazi = {
        enable = true;
        enableFishIntegration = true;
        settings = {
          log = {
            enabled = false;
          };
        };
      };
    };
  };
}
