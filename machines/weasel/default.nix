{lib, ...}: {
  networking = {
    hostName = "weasel";
  };
  environment.pathsToLink = ["/share/applications" "/share/xdg-desktop-portal"];
  wsl.enable = true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  charly = {
    stateVersion = "25.05";
    homeStateVersion = "25.11";
    editor = "nvim";
    core = {
    };
    # development-packages = {
    #   enable = false;
    # };
    hardware = {
      nvidia.enable = false;
      bluetooth.enable = false;
    };
    graphical = {
      enable = false;
      hyprland = {
        enable = false;
      };
    };
  };
}
