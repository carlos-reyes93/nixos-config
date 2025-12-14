{...}: let
  hostName = "nixos";
in {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  nixpkgs.config.allowUnfree = true;
  networking.hostName = hostName;
  networking.networkmanager.enable = true;

  time.timeZone = "America/Mexico_City";
  programs.nix-ld.enable = true;
}
