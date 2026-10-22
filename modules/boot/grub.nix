{ ... }:
{
  boot.loader = {
    systemd-boot.enable = false;
    grub = {
      device = "nodev";
      efiSupport = true;
      efiInstallAsRemovable = true;
    };
  };
}
