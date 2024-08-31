{
  pkgs,
  config,
  lib,
  ...
}: {
  # # Run fish when bash is run in interactive mode
  # programs.bash = {
  #   interactiveShellInit = ''
  #     if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
  #     then
  #       shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
  #       exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
  #     fi
  #   '';
  # };

  programs.fish = {
    enable = true;
    interactiveShellInit = "set fish_greeting";
    shellAliases = {
      "tree" = "eza --tree";
      "nv" = "nvim";
      "ls" = "eza";

      "gs" = "git status";
      "gb" = "git branch";
      "gch" = "git checkout";
      "gc" = "git commit";
      "ga" = "git add";
      "gr" = "git reset --soft HEAD~1";
    };
  };
}
