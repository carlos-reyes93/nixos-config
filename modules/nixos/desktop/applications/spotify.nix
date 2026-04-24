{
  config,
  lib,
  pkgs,
  ...
}: {
  options.charly.graphical.applications.spotify.enable = lib.mkEnableOption "spotify";

  config = lib.mkIf config.charly.graphical.applications.spotify.enable {
    environment.systemPackages = with pkgs; [
      spotify
    ];
  };
}
