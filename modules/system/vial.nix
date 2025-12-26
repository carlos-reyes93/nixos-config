{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    vial-ch.enable = lib.mkEnableOption "enable VIAL system module";
  };
  config = lib.mkIf config.vial-ch.enable {
    environment.systemPackages = with pkgs; [vial];
    services.udev.packages = with pkgs; [vial];
  };
}
