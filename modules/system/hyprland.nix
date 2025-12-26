{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption mkIf types;
  system = pkgs.stdenv.hostPlatform.system;
  cfg = config.charly.hyprland;
in {
  options = {
    charly.hyprland = {
      enable = mkOption {
        description = "hyprland";
        type = types.bool;
        default = false;
      };
    };
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      kitty
      waybar
      wofi
      rofi
      fuzzel
      swww
      inputs.matugen.packages.${system}.default
    ];
    programs.hyprland = {
      enable = true;
      # set the flake package
      package = inputs.hyprland.packages.${system}.hyprland;
      # make sure to also set the portal package, so that they are in sync
      portalPackage = inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
    };

    environment = {
      variables = {
        # If cursor is not visible, try to set this to "on".
        XDG_CURRENT_DESKTOP = "Hyprland";
        XDG_SESSION_TYPE = "wayland";
        XDG_SESSION_DESKTOP = "Hyprland";
      };
      sessionVariables = {
        MOZ_ENABLE_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
        T_QPA_PLATFORM = "wayland";
        GDK_BACKEND = "wayland";
        WLR_NO_HARDWARE_CURSORS = "1";
      };
    };
  };
}
