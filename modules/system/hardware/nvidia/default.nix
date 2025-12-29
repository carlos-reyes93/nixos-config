{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkOption types;
  mod = "nvidia";
  cfg = config.charly.${mod};
in {
  options.charly.${mod}.enable = mkOption {
    description = mod;
    type = types.bool;
    default = false;
  };
  config = mkIf cfg.enable {
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.initrd.kernelModules = [
      "nvidia"
      "i915"
      "nvidia_modeset"
      "nvidia_drm"
    ];
    boot.extraModulePackages = [config.boot.kernelPackages.nvidia_x11];
    boot.kernelParams = [
      "ibt=off"
    ];
    hardware.graphics = {
      enable = true;
    };

    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {
      modesetting.enable = true;

      powerManagement.enable = false;

      powerManagement.finegrained = false;

      open = true;

      nvidiaSettings = true;

      package = config.boot.kernelPackages.nvidiaPackages.mkDriver { 
          version = "590.48.01";
          sha256_64bit = "sha256-ueL4BpN4FDHMh/TNKRCeEz3Oy1ClDWto1LO/LWlr1ok=";
          sha256_aarch64 = "sha256-FOz7f6pW1NGM2f74kbP6LbNijxKj5ZtZ08bm0aC+/YA=";
          openSha256 = "sha256-hECHfguzwduEfPo5pCDjWE/MjtRDhINVr4b1awFdP44=";
          settingsSha256 = "sha256-NWsqUciPa4f1ZX6f0By3yScz3pqKJV1ei9GvOF8qIEE=";
          persistencedSha256 = "sha256-wsNeuw7IaY6Qc/i/AzT/4N82lPjkwfrhxidKWUtcwW8=";
          usePersistenced = true;
        };
    };
  };
}
