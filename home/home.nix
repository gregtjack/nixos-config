{
  inputs,
  username,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./neovim
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    packages = with pkgs; [
      # cli
      neofetch
      ripgrep
      fd
      jq
      dig
      tldr
      tokei
      eza
      fzf
      hyperfine
      zoxide
      bat
      btop
      just
      alejandra

      # apps
      firefox-devedition
      chromium
      kitty
      wezterm
      discord
      prismlauncher
      spotify
      stremio
      obsidian
      vscodium
      pavucontrol
      playerctl
      vlc
      qimgv

      # currently does not work
      # gamescope
    ];
  };

  programs.git = {
    enable = true;
    userEmail = "gregtj30@gmail.com";
    userName = "gregtjack";
  };

  programs.helix = {
    enable = true;
    languages = {
      # the language-server option currently requires helix from the master branch at https://github.com/helix-editor/helix/
      language-server.typescript-language-server = with pkgs.nodePackages; {
        command = "${typescript-language-server}/bin/typescript-language-server";
        args = ["--stdio" "--tsserver-path=${typescript}/lib/node_modules/typescript/lib"];
      };
      language-server.rust-analyzer = with pkgs; {
        command = "${rust-analyzer}/bin/rust-analyzer";
      };
      language = [
        {
          name = "rust";
          auto-format = false;
        }
      ];
    };
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
