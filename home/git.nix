let
  name = "gregtjack";
in {
  programs.git = {
    enable = true;
    settings = {
      user = {
        inherit name;
        email = "gregtj30@gmail.com";
      };
      color.ui = true;
      core.editor = "nvim";
      github.user = name;
      push.autoSetupRemote = true;
    };
  };
}
