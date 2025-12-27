{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption mkIf types;
  system = pkgs.stdenv.hostPlatfrom.system;
  mod = "template";
  cfg = config.charly.${mod};
in {
  options.charly.${mod}.enable = mkOption {
    description = mod;
    type = types.bool;
    default = false;
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [];
    programs."mod" = {
      enable = true;
    };
    environment = {};
  };
}
