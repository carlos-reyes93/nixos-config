{
  config,
  lib,
  pkgs,
  ...
}: {
  options.charly.graphical.sound = {
    enable = lib.mkEnableOption "Sound";
  };

  config = lib.mkIf config.charly.graphical.sound.enable {
    security = {
      rtkit.enable = true;
    };

    environment.systemPackages = with pkgs; [
      pavucontrol
    ];

    hardware = {
      # bluetooth = {
      #   enable = true;
      #   settings = {
      #     General = {
      #       Enable = "Control,Gateway,Headset,Media,Sink,Socket,Source";
      #       MultiProfile = "multiple";
      #     };
      #   };
      # };
      pulseaudio.enable = false;
    };

    services.pipewire = {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
      #jack.enable = true;
    };
  };
}
