{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../../modules/system/kanata.nix
    ./../../modules/system/hardware/nvidia
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services.getty.autologinUser = "charly";
  nixpkgs.config.allowUnfree = true;

  environment.shells = with pkgs; [fish];
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;
  users.groups.uinput = {};

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Mexico_City";

  users.users.charly = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "input"
      "uinput"
    ];
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    foot
    kitty
    waybar
    discord
    wofi
    hyprpaper
    inputs.nix-nvim.packages.${stdenv.hostPlatform.system}.nvim
  ];

  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  system.stateVersion = "25.05";
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  kanata-sys.enable = true;
  nvidia-drivers.enable = true;
}
