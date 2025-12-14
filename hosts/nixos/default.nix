{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../../modules/system/nixos/default.nix
    ./../../modules/system/kanata.nix
    ./../../modules/system/hardware/nvidia
    ./../../modules/user/shells/fish.nix
    ./../../modules/system/hyprland.nix
    ./../../modules/system/greetd.nix
  ];

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };


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
  fonts.packages = with pkgs; [
    inputs.apple-fonts.packages.${pkg.system}.sf-pro-nerd
  ];

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    kitty
    waybar
    vesktop
    wofi
    hyprpaper
    foot
    pavucontrol
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
  fish.enable = true;
}
