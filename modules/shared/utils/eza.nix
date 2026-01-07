{config, ...}: {
  config = {
    home-manager.users.${config.charly.user.name} = {
      programs.eza = {
        enable = true;
        enableFishIntegration = true;
        icons = "auto";
        git = true;
      };
    };
  };
}
