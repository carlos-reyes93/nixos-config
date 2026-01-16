{
  config,
  lib,
  pkgs,
  ...
}: {
  config = {
    programs.fish.enable = true;
    users.defaultUserShell = pkgs.fish;

    home-manager.users.${config.charly.user.name} = {
      programs.fish.enable = true;

      home.shellAliases = with pkgs; {
        ".." = "cd ..";
        cat = "${bat}/bin/bat";
      };
      programs.fish.shellInit = ''
        set -U fish_term24bit 1
        set -gx EDITOR nvim
      '';
      programs.fish.interactiveShellInit = ''

        # Fish syntax highlighting
        set -g fish_color_autosuggestion '555'  'brblack'
        set -g fish_color_cancel -r
        set -g fish_color_command --bold
        set -g fish_color_comment red
        set -g fish_color_cwd green
        set -g fish_color_cwd_root red
        set -g fish_color_end brmagenta
        set -g fish_color_error brred
        set -g fish_color_escape 'bryellow'  '--bold'
        set -g fish_color_history_current --bold
        set -g fish_color_host normal
        set -g fish_color_match --background=brblue
        set -g fish_color_normal normal
        set -g fish_color_operator bryellow
        set -g fish_color_param cyan
        set -g fish_color_quote yellow
        set -g fish_color_redirection brblue
        set -g fish_color_search_match 'bryellow'  '--background=brblack'
        set -g fish_color_selection 'white'  '--bold'  '--background=brblack'
        set -g fish_color_user brgreen
        set -g fish_color_valid_path --underline
      '';
    };
  };
}
