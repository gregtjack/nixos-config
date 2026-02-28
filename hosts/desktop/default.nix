{
  inputs,
  hostname,
  username,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
    ./networking.nix
    ./greetd.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["ntfs"];

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "audio" "video" "docker"];
  };

  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs username;};
    users.${username} = import ./home.nix;
  };

  # Nix features
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;

    # Hyprland binary cache
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # obsidian workaround
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
    "qtwebengine-5.15.19"
  ];
  
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];

  environment.systemPackages = with pkgs; [
    wget
    curl
    git
    vim
    inetutils
    adwaita-icon-theme
    nautilus
    nwg-look
    glib
    wl-clipboard
    cliphist
    grim
    slurp
    rofi # runner
    mako # notifications
    swww # wallpapers
    hypridle # idle manager
    hyprlock # lock
  ];

  programs = {
    steam.enable = true;
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    };
    niri.enable = true;
  };

  virtualisation.docker.enable = true;

  fonts = {
    packages = with pkgs; [
      noto-fonts
      inter
      helvetica-neue-lt-std
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
    ];

    fontconfig.defaultFonts = {
      sansSerif = ["Inter" "Noto Sans"];
    };
  };

  security = {
    polkit.enable = true;
    pam.services.ags = {};
  };

  services.desktopManager.plasma6.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.flatpak.enable = true;

  # Sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
