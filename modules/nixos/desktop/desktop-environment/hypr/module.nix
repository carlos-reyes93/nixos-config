{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption mkIf types;
  system = pkgs.stdenv.hostPlatform.system;
  cfg = config.charly.graphical.hyprland;
in {
  options = {
    charly.graphical.hyprland = {
      enable = mkOption {
        description = "hyprland";
        type = types.bool;
        default = false;
      };
    };
  };
  imports = [
    ./greetd.nix
    ./noctalia.nix
  ];
  config = mkIf cfg.enable {
    nix.settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
    environment.systemPackages = with pkgs; [
      kitty
      waybar
      wl-clipboard
      hyprpaper
      fuzzel
      swww
      inputs.matugen.packages.${system}.default
      inputs.rose-pine-hyprcursor.packages.${stdenv.hostPlatform.system}.default
    ];
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${system}.hyprland;
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
