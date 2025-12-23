{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    fish.enable = lib.mkEnableOption "Enable Foot and Fish integration";
  };

  config = lib.mkIf config.fish.enable {
    environment.shells = with pkgs; [fish];
    users.defaultUserShell = pkgs.fish;
    programs.fish = {
      enable = true;
      shellInit = ''

        set -gx EDITOR nvim
      '';
    };
  };
}
