{
  config,
  lib,
  ...
}: {
  imports = [
    ./applications
    ./desktop-environment
    ./gaming
  ];
  options.charly.graphical = {
    enable = lib.mkEnableOption "graphical environment";
  };

  # TODO: Create a nicer options structure
  config = lib.mkIf config.charly.graphical.enable {
    charly = {
      graphical = {
        hyprland.enable = lib.mkDefault true;
        # hyprlock.enable = lib.mkDefault true;
        # hyprpaper.enable = lib.mkDefault true;
        # waybar.enable = lib.mkDefault true;
        # swaync.enable = lib.mkDefault true;
        # xdg.enable = lib.mkDefault true;
        # fuzzel.enable = lib.mkDefault true;
        # key_management.enable = lib.mkDefault true;
        # theme.enable = lib.mkDefault true;
        # sound.enable = lib.mkDefault true;
        gaming = {
          steam.enable = lib.mkDefault true;
          lutris.enable = lib.mkDefault true;
        };
        applications = {
          firefox.enable = lib.mkDefault true;
          obsidian.enable = lib.mkDefault true;
          vial.enable = lib.mkDefault true;
          foot.enable = lib.mkDefault true;
          antimicrox.enable = lib.mkDefault true;
          vesktop.enable = lib.mkDefault true;
        };
      };
    };
  };
}
