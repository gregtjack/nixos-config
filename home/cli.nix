{pkgs, ...}: {
  home.packages = with pkgs; [
    neofetch
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
    just
    alejandra
  ];
}