{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption mkIf types;
  system = pkgs.stdenv.hostPlatfrom.system;
  mod = "lutris";
  cfg = config.charly.${mod};
in {
  options.charly.lutris.enable = mkOption {
    description = mod;
    type = types.bool;
    default = false;
  };
  config = mkIf cfg.enable {
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
