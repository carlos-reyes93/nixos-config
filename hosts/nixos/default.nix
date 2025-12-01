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
    ./../../modules/user/shells/fish-foot.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  nixpkgs.config.allowUnfree = true;
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Mexico_City";

  services.getty.autologinUser = "charly";
  users.groups.uinput = {};
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
  fish-foot.enable = true;
}
