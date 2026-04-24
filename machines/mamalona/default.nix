{pkgs, ...}: {
  imports = [./hardware.nix];

  networking = {
    hostName = "mamalona";
    nameservers = ["1.1.1.1" "1.0.0.1"];
    firewall = {
      enable = true;
      allowedTCPPorts = [34585];
      allowedUDPPorts = [34585];
    };
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.waylandFrontend =  true;
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
    ];
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
      bluetooth.enable = true;
    };
    graphical = {
      enable = true;
      hyprland = {
        enable = true;
      };
    };
  };
}
