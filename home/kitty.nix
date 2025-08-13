{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    shellIntegration.enableFishIntegration = true;
    settings = {
      font_family = "FiraCode Nerd Font";
      background_opacity = "1";
      shell = "fish";
      editor = "nvim";
    };
  };
}
