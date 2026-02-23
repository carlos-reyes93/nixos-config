{
  pkgs,
  lib,
  config,
  ...
}: {
  options.charly.graphical.gaming.lutris.enable = lib.mkEnableOption "lutris";

  config = lib.mkIf config.charly.graphical.gaming.lutris.enable {
    programs.nix-ld.enable = true;
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
          brotli
          nspr
          nss
          libxkbcommon
          libGL
          libGLU
          libevent
          openssl
          libxml2_13

          # X11 & XCB Suite (CRITICAL for Qt6 / Tibia 13+)
          xorg.libX11
          xorg.libXdamage
          xorg.libxkbfile
          xorg.libxcb
          xorg.xcbutil
          xorg.xcbutilwm
          xorg.xcbutilimage
          xorg.xcbutilkeysyms
          xorg.xcbutilrenderutil
          xorg.xcbutilcursor
          xorg.libXi
          xorg.libXrender
        ];
      })
    ];
  };
}
