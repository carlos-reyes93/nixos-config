{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.matugen.nixosModules.default
  ];

  programs.matugen = {
    enable = true;
    variant = "dark";
    jsonFormat = "hex";
    palette = "default";
    wallpaper = ./../../wallpaper.jpg;
  };

  home.configFile."hypr".source = "${config.programs.matugen.theme.files}/.config/hypr/colors.conf";
}
