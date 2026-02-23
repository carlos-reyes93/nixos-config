{
  config,
  lib,
  pkgs,
  ...
}: {
  options.charly.services.piper = {
    enable = lib.mkEnableOption "Piper";
  };

  config = lib.mkMerge [
    (lib.mkIf (config.charly.isLinux && config.charly.services.sshd.enable) {
      services.ratbagd.enable = true;
      environment.systemPackages = [
        pkgs.piper
      ];
    })
  ];
}
