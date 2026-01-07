{config, ...}: {
  config = {
    home-manager.users.${config.charly.user.name} = {
      programs.zoxide = {
        enable = true;
        enableFishIntegration = true;
      };
    };
  };
}
