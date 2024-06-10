{
  inputs,
  username,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ../../home/neovim.nix
    ../../home/cli.nix
    ../../home/git.nix
    ../../home/fish.nix
    ../../home/kitty.nix
    ../../home/waybar
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    packages = with pkgs; [
      # apps
      firefox
      chromium
      discord
      prismlauncher
      spotify
      stremio
      obsidian
      vscodium
      playerctl
      mpv
      qimgv
      tidal-hifi
    ];
  };

  programs.direnv = {
    enable = true;
  };

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
