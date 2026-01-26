{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.nixos-wsl.nixosModules.default
  ];

  wsl = {
    enable = true;

    defaultUser = "charly";
  };

  networking = {
    hostName = "weasel";
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  charly = {
    stateVersion = "25.05";
    homeStateVersion = "25.11";
  };
}
