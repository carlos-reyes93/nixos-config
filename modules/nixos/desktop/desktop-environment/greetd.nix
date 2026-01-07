{
  pkgs,
  inputs,
  ...
}: let
  tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
  hyprland-session = "${pkgs.hyprland}/share/wayland-sessions";
  hyprland = inputs.hyprland.packages.${system}.hyprland;
  system = pkgs.stdenv.hostPlatform.system;
in {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${tuigreet} --time --remember --remember-session --sessions ${hyprland-session}";
        user = "greeter";
      };
      initial_session = {
        command = "${hyprland}/bin/Hyprland";
        user = "charly";
      };
    };
  };
}
