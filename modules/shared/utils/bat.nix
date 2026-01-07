{ config, ... }:
{
  config = {
    home-manager.users.${config.charly.user.name} = {
      programs.bat = {
        enable = true;
      };
    };
  };
}
