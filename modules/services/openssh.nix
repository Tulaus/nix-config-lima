{ ... }:
{
  services.openssh = {
    enable = true;
    authorizedKeysFiles = [
      "/etc/ssh/lima-managed-keys/%u"
    ];
    settings.LogLevel = "DEBUG3";
  };
}
