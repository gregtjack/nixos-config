{pkgs, ...}: {
  home.packages = with pkgs; [
    fastfetch
    ripgrep
    fd
    jq
    dig
    tokei
    eza
    fzf
    hyperfine
    zoxide
    bat
    btop
    htop
    just
    alejandra
  ];
}
