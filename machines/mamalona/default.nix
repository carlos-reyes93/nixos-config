{...}: {
  imports = [./hardware.nix];

  networking = {
    hostName = "mamalona";
    nameservers = ["1.1.1.1" "1.0.0.1"];
  };

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
      nvidia.enable = true;
    };
    graphical = {
      enable = true;
      hyprland = {
        enable = true;
      };
    };
  };
}
