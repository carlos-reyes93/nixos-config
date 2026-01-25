{
  config,
  lib,
  pkgs,
  ...
}: {
  options.charly.graphical.applications.antimicrox.enable = lib.mkEnableOption "antimicrox";

  config = lib.mkIf config.charly.graphical.applications.antimicrox.enable {
    environment.systemPackages = with pkgs; [
      antimicrox
    ];
  };
}
