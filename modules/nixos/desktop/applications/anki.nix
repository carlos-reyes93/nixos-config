{
  config,
  lib,
  pkgs,
  ...
}: {
  options.charly.graphical.applications.anki.enable = lib.mkEnableOption "anki";

  config = lib.mkIf config.charly.graphical.applications.anki.enable {
    environment.systemPackages = with pkgs; [
      anki
    ];
  };
}
