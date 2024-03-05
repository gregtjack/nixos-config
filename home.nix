{ pkgs, ... }: {

  home.username = "greg";
  home.homeDirectory = "/home/greg";

  home.packages = with pkgs; [  
    neovim 
    neofetch
    helix

    # cli utils
    ripgrep
    jq
    dig
    tldr
    tokei
    eza
    hyperfine
    zoxide
    bat
    btop
    just

    # Apps 
    firefox
    kitty
    discord
    prismlauncher
    spotify
    stremio
    obsidian
    vscodium    
    vlc

    # games 
    gamescope
  ];

  programs.git = {
    enable = true;

    userEmail = "gregtj30@gmail.com";
    userName = "gregtjack";
  };

  programs.fish.enable = true;
  programs.direnv = {
    enable = true;
  };

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
