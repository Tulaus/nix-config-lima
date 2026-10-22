{ pkgs, inputs, ... }:
let unstable = import inputs.nixpkgs-unstable {
  system = pkgs.stdenv.hostPlatform.system;
  config = { allowUnfree = true; };
};
in {
  programs = {
    vim.enable = true;
    yt-dlp.enable = true;
    fzf.enable = true;
    btop.enable = true;
    tmux.enable = true;
    codex = {
      enable = true;
      package = unstable.codex;
    };
  };
  home.packages = with pkgs; [
    wget
    (fortune.override { withOffensive = true; })
    fastfetch
    ncdu
    unstable.p7zip-rar
    python314
    restic
    rclone
    ncdu
  ];
}
