{ config, pkgs, ... }:
{
  wsl.enable = true;
  wsl.defaultUser = "charly";
  wsl.wslConf.network.hostname = "weasel";
}
