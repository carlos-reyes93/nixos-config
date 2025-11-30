{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    nvidia-drivers.enable = lib.mkEnableOption "Enable Nvidia Drivers";
  };
  config = lib.mkIf config.nvidia-drivers.enable {
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

      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
