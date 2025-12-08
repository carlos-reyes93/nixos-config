{
  inputs,
  pkgs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  hyprland-pkg = inputs.hyprland.packages.${system}.hyprland;
  hyprland-session = "${hyprland-pkg}/share/wayland-sessions";
in {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${tuigreet} --time --remember --remember-session --sessions ${hyprland-session}";
        user = "greeter";
      };
    };
  };
  environment.systemPackages = with pkgs; [
    kitty
    waybar
    wofi
    rofi
    fuzzel
    swww
    quickshell
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
}
