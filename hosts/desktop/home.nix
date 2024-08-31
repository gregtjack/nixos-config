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
    ../../home/starship.nix
    ../../home/kitty.nix
    ../../home/hyprland.nix
    ../../home/tmux.nix
    ../../home/waybar
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    packages = with pkgs; [
      # apps
      ungoogled-chromium
      firefox
      prismlauncher
      spotify
      stremio
      obsidian
      vscodium
      zed-editor
      playerctl
      mpv
      qimgv
      tidal-hifi
      webcord-vencord
    ] ++ [inputs.zen-browser.packages."${system}".default];
  };

  programs.direnv = {
    enable = true;
  };

  programs.librewolf.enable = true;

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
