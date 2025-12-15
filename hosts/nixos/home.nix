{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  dotfiles = config.lib.file.mkOutOfStoreSymlink config.home.mutableFile.files."dotfiles".path;
  nix-nvim = config.lib.file.mkOutOfStoreSymlink config.home.mutableFile.files."nix-nvim".path;
in {
  imports = [
    ./../../modules/user/terminal-multiplexers/tmux.nix
    ./../../modules/home-manager/direnv.nix
  ];
  config = {
    home.username = "charly";
    home.homeDirectory = "/home/charly";
    home.enableNixpkgsReleaseCheck = false;
    fetch-mutable-files.enable = true;
    home.mutableFile = {
      baseDir = "${config.home.homeDirectory}/repos";
      files = {
        "dotfiles" = {
          url = "https://github.com/carlos-reyes93/dotfiles.git";
          type = "git";
          path = "dotfiles";
        };
        "nix-nvim" = {
          url = "https://github.com/carlos-reyes93/nix-nvim.git";
          type = "git";
          path = "nix-nvim";
        };
      };
    };

    home.stateVersion = "25.11";

    home.packages = [
      pkgs.nerd-fonts.fira-code
      pkgs.nerd-fonts.iosevka
      pkgs.fish
      pkgs.neofetch
      pkgs.fzf
    ];

    home.sessionVariables = {
      EDITOR = "nvim";
    };

    programs.home-manager.enable = true;

    programs.starship = {
      enable = true;
    };

    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "Carlos Reyes";
          email = "contacto@carlosreyc.dev";
        };
      };
    };

    xdg.configFile = {
      nvim.source = "${nix-nvim}";
      fish.source = "${dotfiles}/shell/fish";
      "starship.toml".source = "${dotfiles}/shell/starship/starship.toml";
      foot.source = "${dotfiles}/programs/foot";
    };
  };
}
