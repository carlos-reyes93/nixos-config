{
  config,
  lib,
  pkgs,
  ...
}: {
  options.charly.graphical.applications.torrent.enable = lib.mkEnableOption "torrent";

  config = lib.mkIf config.charly.graphical.applications.torrent.enable {
    environment.systemPackages = with pkgs; [
      qbittorrent-enhanced
    ];
  };
}
