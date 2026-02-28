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

    packages = with pkgs;
      [
        # apps
        ungoogled-chromium
        firefox
        prismlauncher
        spotify
        obsidian
        vscodium
        zed-editor
        code-cursor
        playerctl
        mpv
        qimgv
        discord
        ghostty
	railway
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
