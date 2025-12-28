{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption mkIf types;
  mod = "noctalia-shell";
  cfg = config.charly.${mod};
in {
  options.charly.${mod}.enable = mkOption {
    description = mod;
    type = types.bool;
    default = false;
  };
  config = mkIf cfg.enable {
    services.noctalia-shell = {
      enable = true;
    };
  };
}
