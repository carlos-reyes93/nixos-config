{
  config,
  pkgs,
  inputs,
  ...
}: {
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };
  
  programs.steam.enable = true;
  programs.gamemode.enable = true;
  
  environment.systemPackages = with pkgs; [mangohud protonup-qt lutris bottles heroic];

  services.xserver.videoDrivers = ["nvidia"];
}
