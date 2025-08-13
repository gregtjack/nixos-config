{pkgs, ...}: {
  home.packages = with pkgs; [
    # utils
    fastfetch
    ripgrep
    fd
    jq
    dig
    tokei
    eza
    fzf
    zoxide
    bat
    btop
    htop
    just
    hyperfine
    alejandra
  ];
}
