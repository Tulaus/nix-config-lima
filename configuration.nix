# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{

  services.lima.enable = true;
  users.mutableUsers = true;

  boot.loader = {
    systemd-boot.enable = false;
    grub = {
      device = "nodev";
      efiSupport = true;
      efiInstallAsRemovable = true;
    };
  };

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  networking.hostName = "lima"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  users.users.chris = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCg88GUiVCOaDnv2IRdcLDrnpTvpgFRi9Dzyf8l78ikoRX2vEkmT2ucUXvMhFULL9LHw1qDHgGctTCT2cr3VSJ17r/8Fbafq18Y7D6L1n9wgK4khdpkqy7BYHowbPpygroDAVGHIu5wgMaFGOHcanQntcFBqhGAhLYri0XQSO2OHlEgQFmVBS/usBAfcRMmxTzQ9QKFf/NLixymTQcXOO1grIqfBL6Y1vtXihPbU0xrmH6uNnlJqK/xVMqu3w5g09sLUZFoJjB2hQTaLyfAkiU4Co4HSktNzPqCc8a0TBxW32WjCcu6jinvPdPzBrQdR1+N4235lyA1vR27srxkd0gSgl84Dl2DXhfdbRUfg6sjQvvnNlxGHBXLZFmh8qGO8WOlppT9+3KSDYx/LVubRm8M7opyy3Q8h4YsnF/Ffb+86Nm9XLHRiF+DIF4mw/7ixSqveM4jqDSfAye0FyHumoxnHFw7hA9l+XSthNPFInDUZtQw7bRFL2JY3XO6ki5AIf0= chris@Chriss-MacBook-Pro.local"
    ];
    packages = with pkgs; [
      tree
    ];
    shell = pkgs.fish;
  };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim
    wget
    gnupg
    git
    btop
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gtk2;
    enableSSHSupport = true;
  };

  programs = {
    fish.enable = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    authorizedKeysFiles = [
      "/etc/ssh/lima-managed-keys/%u"
    ];
    settings.LogLevel = "DEBUG3";
  };

  environment.etc."ssh/lima-managed-keys/chris" = {
    text = ''
      ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII9gU5aSVbFLF6YaLR3a6e/dPD1KsdtLNcnwnHATZVYK lima
    '';
    # Create a real file instead of a symlink into /nix/store.
    mode = "0644";
    user = "root";
    group = "root";
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  nixpkgs.config.allowUnfree = true;
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
    };
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}

