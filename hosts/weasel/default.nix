{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./../../modules/system/nixos/wsl.nix
    ./../../modules/user/shells/fish.nix
  ];

  environment.systemPackages = with pkgs; [
    git
    gcc
    vim
    wget
    fish
    starship
    inputs.nix-nvim.packages.${stdenv.hostPlatform.system}.nvim
  ];
  system.stateVersion = "25.05";
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  fish.enable = true;
}
