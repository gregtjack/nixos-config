let
  name = "gregtjack";
in
{
  programs.git = {
    enable = true;
    userEmail = "gregtj30@gmail.com";
    userName = name;
    extraConfig = {
      color.ui = true;
      core.editor = "nvim";
      github.user = name;
      push.autoSetupRemote = true;
    };
  };
}