{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./../../modules/system/nixos/wsl.nix
  ];

  environment.shells = with pkgs; [ fish ];
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    git
    gcc
    vim
    wget
    fish
    starship
    neovim
    nil
    nixd
  ];
  system.stateVersion = "25.05";
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
