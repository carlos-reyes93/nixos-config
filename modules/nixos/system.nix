{ config, lib, pkgs, ... }:
{
  config = {
    system = {
      autoUpgrade = {
        enable = lib.mkDefault true;
        flake = "github:carlos-reyes93/nixos-config";
        dates = "01/04:00";
        randomizedDelaySec = "15min";
      };
    };

    security = {
      sudo = {
        enable = false;
      };

      doas = {
        enable = true;
        extraRules = [
          {
            users = [ config.charly.user.name ];
            noPass = true;
          }
        ];
      };

      polkit = {
        enable = true;
      };
    };

    environment.systemPackages = with pkgs; [
      lshw
      iproute2
    ];

    services = {
      fwupd = {
        enable = true;
      };
    };

    i18n = {
      defaultLocale = "en_US.UTF-8";
    };
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  };
}
