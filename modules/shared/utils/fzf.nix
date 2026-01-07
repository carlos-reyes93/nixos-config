{config, ...}: {
  config = {
    home-manager.users.${config.charly.user.name} = {
      programs.fzf = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  };
}
