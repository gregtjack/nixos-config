# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  inputs,
  hostname,
  username,
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = hostname; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # proton vpn
  networking.wg-quick.interfaces = {
    wg-pvpn-us = {
      autostart = false;
      address = ["10.2.0.2/32"];
      listenPort = 51820;
      privateKeyFile = "/etc/keys/protonvpn.key";
      peers = [
        {
          publicKey = "mqoQwexGzvYJ63u35PJukMOleZXRLLkfQKODwm3NPB4=";
          allowedIPs = ["0.0.0.0/0" "::/0"];
          endpoint = "37.19.221.197:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };

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
    description = "Greg Jackson";
    extraGroups = ["networkmanager" "wheel" "audio" "video"];
    shell = pkgs.fish;
  };

  # Nix features
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;

    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # obsidian workaround
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  environment.systemPackages = with pkgs; [
    # essentials
    vim
    wget
    curl
    git
    gnome.adwaita-icon-theme

    # clipboard
    wl-clipboard
    cliphist

    tofi # runner
    mako # notifications
    swww # wallpapers
  ];
  
  programs = {
    hyprland = {
      enable = true;
      # Use the development version of hyprland
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      xwayland.enable = true;
    };

    waybar.enable = true;
    steam.enable = true;
    fish.enable = true;
  };

  # fonts
  fonts.packages = with pkgs; [
    noto-fonts
    helvetica-neue-lt-std
    (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})
  ];
  
  security = {
    polkit.enable = true;
    pam.services.ags = {};
  };

  services.gnome.gnome-keyring.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fai.
    powerManagement.enable = false;
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

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
