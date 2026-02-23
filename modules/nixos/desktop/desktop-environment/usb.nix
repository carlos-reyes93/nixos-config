{
  pkgs,
  inputs,
  config,
  ...
}: let
in {
  services.udisks2.enable = true;

  home-manager.users.${config.charly.user.name} = {
    services.udiskie = {
      enable = true;
    };
  };
}
