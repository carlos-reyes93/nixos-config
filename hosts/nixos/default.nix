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
    # ./../../modules/user/shells/fish.nix
    ./../../modules/system/wms/hyprland/default.nix
    ./../../modules/system/gaming/default.nix
    ./../../modules/system/vial.nix
    ./../../modules/desktop/commons/default.nix
    inputs.noctalia.nixosModules.default
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

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    vesktop
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
  charly.kanata.enable = false;
  charly.nvidia.enable = true;
  charly.gaming.enable = true;
  charly.vial.enable = true;
  charly.hyprland.enable = true;
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;
}
