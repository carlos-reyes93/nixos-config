{ config, pkgs, ... }:
{
  wsl.enable = true;
  wsl.defaultUser = "charly";
  wsl.wslConf.network.hostname = "weasel";
  time.timeZone = "America/Mexico_City";
}
