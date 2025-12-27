{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkOption mkIf types;
  mod = "vial";
  cfg = config.charly.${mod};
in 
{
  options.charly.${mod}.enable = mkOption {
    description = mod;
    type = types.bool;
    default = false;
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [vial];
    services.udev.packages = with pkgs; [vial];
  };
}
