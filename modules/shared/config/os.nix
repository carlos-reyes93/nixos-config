{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkOption types;
in {
  options = {
    charly.isLinux = mkOption {
      type = types.bool;
      readOnly = true;
      description = "Wheter the host is a Linux system";
    };

    charly.isDarwin = mkOption {
      type = types.bool;
      readOnly = true;
      description = "Wheter the host is a Darwin system";
    };
    charly.font = lib.mkOption {
      type = lib.types.str;
      description = "Default font for the system.";
    };

    charly.colorScheme.flavor = lib.mkOption {
      type = lib.types.str;
      description = "Default flavor for the color scheme.";
      default = "mocha";
    };

    charly.colorScheme.accent = lib.mkOption {
      type = lib.types.str;
      description = "Default accent for the color scheme.";
      default = "peach";
    };

    # System version option
    charly.stateVersion = lib.mkOption {
      type = lib.types.str;
      example = "25.05";
      description = "NixOS state version";
    };
    charly.homeStateVersion = lib.mkOption {
      type = lib.types.str;
      example = "25.11";
      description = "HomeManager state version";
    };

    charly.timeZone = lib.mkOption {
      type = lib.types.str;
      default = "America/Mexico_City";
      description = "Time zone for the system.";
    };

    charly.core = lib.mkOption {
      type = lib.types.submodule {};
      default = {};
      description = "Namespace for Linux-only core settings. Empty on Darwin.";
    };
    charly.editor = lib.mkOption {
      type = lib.types.str;
      default = "nvim";
      description = "Default editor";
    };
  };

  config = {
    charly.isLinux = lib.charly.isLinux;
    charly.isDarwin = lib.charly.isDarwin;
    charly.font = "0xFiraCode Nerd Font";
  };
}
