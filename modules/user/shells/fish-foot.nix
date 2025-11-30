{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    fish-foot.enable = lib.mkEnableOption "Enable Foot and Fish integration";
  };

  config = lib.mkIf config.fish-foot.enable {
    environment.shells = with pkgs; [fish];
    users.defaultUserShell = pkgs.fish;
    programs.fish.enable = true;
    environment.systemPackages = with pkgs; [
      foot
    ];
  };
}
