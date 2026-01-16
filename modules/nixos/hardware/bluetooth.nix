{
  config,
  lib,
  ...
}: {
  options.charly.hardware.bluetooth.enable = lib.mkEnableOption "bluetooth";
  config = lib.mkIf config.charly.hardware.bluetooth.enable {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.settings = {
      General = {
        FastConnectable = true;
        Experimental = true;
      };
    };
    services.joycond.enable = true;
  };
}
