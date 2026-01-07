{ config, ... }:
{
  config = {
    home-manager.users.${config.charly.user.name} = {
      programs.ripgrep = {
        enable = true;
      };
    };
  };
}
