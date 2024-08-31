{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";
    shellIntegration.enableFishIntegration = true;
    settings = {
      font_family = "FiraCode Nerd Font";
      background_opacity = "1";
      shell = "fish";
      editor = "nvim";
    };
  };
}
