{
  inputs,
  username,
  pkgs,
  ...
}: {
  # imports = [ inputs.ags.homeManagerModules.default ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    packages = with pkgs; [
      neovim
      neofetch
      helix

      tofi # runner
      mako # notifications
      swww # wallpapers

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
      alejandra

      # apps
      firefox
      kitty
      discord
      prismlauncher
      spotify
      stremio
      obsidian
      vscodium
      vlc

      # currently does not work
      # gamescope
    ];
  };

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
