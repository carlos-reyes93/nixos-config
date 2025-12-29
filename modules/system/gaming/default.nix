{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkOption mkIf types;
  mod = "gaming";
  cfg = config.charly.${mod};
in {
  imports = [
    ./lutris.nix
  ];
  options.charly.${mod}.enable = mkOption {
    description = mod;
    type = types.bool;
    default = false;
  };
  config = mkIf cfg.enable {
    programs = {
      steam = {
        enable = true;
        package = pkgs.steam.override {
          extraPkgs = pkgs':
            with pkgs'; [
              xorg.libXcursor
              xorg.libXi
              xorg.libXinerama
              xorg.libXScrnSaver
              libpng
              libpulseaudio
              libvorbis
              stdenv.cc.cc.lib # Provides libstdc++.so.6
              libkrb5
              keyutils
              # Add other libraries as needed
            ];
        };
      };
      gamemode = {
        enable = true;
      };
    };

    environment.systemPackages = with pkgs; [
      mangohud
      protonup-qt
      bottles
      heroic
    ];

    charly.lutris.enable = true;
  };
}
