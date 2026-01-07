{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.charly.graphical.applications.obsidian.enable = lib.mkEnableOption "obsidian";

  config = lib.mkIf config.charly.graphical.applications.obsidian.enable {
    environment.systemPackages = with pkgs; [
      obsidian
    ];
  };
}
