{
  config,
  lib,
  ...
}: {
  options.charly.graphical.applications.vesktop.enable = lib.mkEnableOption "vesktop";

  config = lib.mkIf config.charly.graphical.applications.vesktop.enable {
    home-manager.users.${config.charly.user.name} = {
      programs.vesktop.enable = true;
    };
  };
}
