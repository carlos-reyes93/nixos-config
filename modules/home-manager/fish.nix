{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkOption types;
  mod = "fish";
  cfg = config.charly.${mod};
in {
  imports = [ ./starship/starship.nix ];
  options.charly.${mod}.enable = mkOption {
    description = mod;
    type = types.bool;
    default = false;
  };

  config = mkIf cfg.enable {
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
}
