{
  pkgs,
  lib,
  config,
  ...
}: {
  options.charly.graphical.gaming.lutris.enable = lib.mkEnableOption "lutris";

  config = lib.mkIf config.charly.graphical.gaming.lutris.enable {
    environment.systemPackages = with pkgs; [
      (lutris.override {
        extraPkgs = pkgs: let
          libxml2_13 = pkgs.libxml2.overrideAttrs rec {
            version = "2.13.8";

            src = pkgs.fetchurl {
              url = "mirror://gnome/sources/libxml2/${pkgs.lib.versions.majorMinor version}/libxml2-${version}.tar.xz";
              hash = "sha256-J3KUyzMRmrcbK8gfL0Rem8lDW4k60VuyzSsOhZoO6Eo=";
            };
          };
        in [
          # Tibia
          brotli
          nspr
          nss
          libxkbcommon
          libGL
          libGLU
          libevent
          xorg.libXdamage
          xorg.libxkbfile
          openssl
          libxml2_13
        ];
      })
    ];
  };
}
