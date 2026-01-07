{
  config,
  lib,
  pkgs,
  ...
}: {
  options.charly.graphical.applications.vial.enable = lib.mkEnableOption "vial";

  config = lib.mkIf config.charly.graphical.applications.vial.enable {
    environment.systemPackages = with pkgs; [
      vial
    ];
    services.udev.packages = with pkgs; [vial];
  };
}
