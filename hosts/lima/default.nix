{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./../../profiles/lima
  ];
  
  networking.hostName = "lima";
  system.stateVersion = "26.05"; # I'm running out of yarara jokes
}
