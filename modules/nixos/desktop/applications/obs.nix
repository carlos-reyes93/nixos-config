{
  config,
  lib,
  pkgs,
  ...
}: {
  options.charly.graphical.applications.obs.enable = lib.mkEnableOption "obs";

  config = lib.mkIf config.charly.graphical.applications.obs.enable {
    programs.obs-studio = {
      enable = true;

      # optional Nvidia hardware acceleration
      package = (
        pkgs.obs-studio.override {
          cudaSupport = true;
        }
      );

      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-vkcapture
        obs-browser-transition
      ];

      enableVirtualCamera = true;
    };
  };
}
