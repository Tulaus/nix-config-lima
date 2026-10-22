{ ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    wget
    gnupg
    git
    btop
  ];
}
