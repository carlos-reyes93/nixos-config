{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: let
  inherit (lib) mkOption mkIf types;
  mod = "gaming";
  cfg = config.charly.${mod};
in {
  imports = [
    ./lutris.nix
  ];
  options.charly.${mod}.enable = mkOption {
    description = mod;
    type = types.bool;
    default = false;
  };
  config = mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
    };

    programs.steam.enable = true;
    programs.gamemode.enable = true;

    environment.systemPackages = with pkgs; [mangohud protonup-qt bottles heroic];

    services.xserver.videoDrivers = ["nvidia"];
    charly.lutris.enable = true;
  };
}
