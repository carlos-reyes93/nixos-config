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
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services.getty.autologinUser = "charly";
  nixpkgs.config.allowUnfree = true;

  environment.shells = with pkgs; [fish];
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;
  kanata-sys.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = ["uinput"];
  boot.initrd.kernelModules = [
    "nvidia"
    "i915"
    "nvidia_modeset"
    "nvidia_drm"
  ];
  boot.extraModulePackages = [config.boot.kernelPackages.nvidia_x11];
  boot.kernelParams = [
    "ibt=off"
  ];
  hardware.uinput.enable = true;
  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement.enable = false;

    powerManagement.finegrained = false;

    open = true;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
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
    gcc
    wget
    foot
    kitty
    waybar
    discord
    kanata
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
}
