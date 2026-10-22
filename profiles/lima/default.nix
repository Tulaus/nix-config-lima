{ pkgs, ... }:
{
  imports = [
    ./localization.nix
    ./packages.nix
    ./shell.nix
    ./../../modules/boot/grub.nix
    ./../../modules/nix
    ./../../modules/networking
    ./../../modules/services
    ./../../modules/users/chris.nix
  ];
  
  environment.etc."ssh/lima-managed-keys/chris" = {
    text = ''
      ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII9gU5aSVbFLF6YaLR3a6e/dPD1KsdtLNcnwnHATZVYK lima
      ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCg88GUiVCOaDnv2IRdcLDrnpTvpgFRi9Dzyf8l78ikoRX2vEkmT2ucUXvMhFULL9LHw1qDHgGctTCT2cr3VSJ17r/8Fbafq18Y7D6L1n9wgK4khdpkqy7BYHowbPpygroDAVGHIu5wgMaFGOHcanQntcFBqhGAhLYri0XQSO2OHlEgQFmVBS/usBAfcRMmxTzQ9QKFf/NLixymTQcXOO1grIqfBL6Y1vtXihPbU0xrmH6uNnlJqK/xVMqu3w5g09sLUZFoJjB2hQTaLyfAkiU4Co4HSktNzPqCc8a0TBxW32WjCcu6jinvPdPzBrQdR1+N4235lyA1vR27srxkd0gSgl84Dl2DXhfdbRUfg6sjQvvnNlxGHBXLZFmh8qGO8WOlppT9+3KSDYx/LVubRm8M7opyy3Q8h4YsnF/Ffb+86Nm9XLHRiF+DIF4mw/7ixSqveM4jqDSfAye0FyHumoxnHFw7hA9l+XSthNPFInDUZtQw7bRFL2JY3XO6ki5AIf0= chris@Chriss-MacBook-Pro.local
    '';
    # Create a real file instead of a symlink into /nix/store.
    mode = "0644";
    user = "root";
    group = "root";
  };
  
  nix.gc.options = "--delete-older-than 30d";
}
