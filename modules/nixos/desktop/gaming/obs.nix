{
  config,
  pkgs,
  lib,
  ...
}: {
  options.charly.graphical.gaming.steam.enable = lib.mkEnableOption "steam";
  config = lib.mkIf config.charly.graphical.gaming.steam.enable {
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
  };
}
