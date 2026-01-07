{
  lib,
  pkgs,
  config,
  ...
}:
{
  options.charly.user = {
    name = lib.mkOption {
      type = lib.types.str;
      default = "charly";
      description = "Primary user name";
    };

    fullName = lib.mkOption {
      type = lib.types.str;
      default = "Carlos Reyes";
      description = "User full name";
    };

    email = lib.mkOption {
      type = lib.types.str;
      default = "contacto@carlosreyc.dev";
      description = "User email address";
    };

    workEmail = lib.mkOption {
      type = lib.types.str;
      default = "reyesc@delagelanden.com";
      description = "Work email address";
    };

    gpgKey = lib.mkOption {
      type = lib.types.str;
      default = "52BFF6CCB1DA1915821F741BF29959D9BAB9798F";
      description = "User GPG key";
    };

    homeDirectory = lib.mkOption {
      type = lib.types.str;
      description = "User home directory";
    };

    shell = lib.mkOption {
      type = lib.types.str;
      default = "fish";
      description = "Default shell";
    };

    editor = lib.mkOption {
      type = lib.types.str;
      default = "nvim";
      description = "Default editor";
    };
  };

  config = {
    charly.user.homeDirectory = lib.mkDefault (
      if config.charly.isDarwin then
        "/Users/${config.charly.user.name}"
      else
        "/home/${config.charly.user.name}"
    );

    users =
      # Add mutableUsers only on NixOS; nix-darwin does not have this option.
      {
        users.${config.charly.user.name} = lib.mkMerge [
          # Base user configuration
          {
            home = config.charly.user.homeDirectory;
          }
          # Linux-specific user configuration
          (lib.mkIf config.charly.isLinux {
            isNormalUser = true;
            group = config.charly.user.name;
            extraGroups = lib.mkIf config.charly.isLinux [ "systemd-journal" ];
          })
        ];
        groups.${config.charly.user.name} = { };
      };
  };
}
