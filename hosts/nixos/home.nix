{
  config,
  lib,
  pkgs,
  ...
}: let
  dotfiles = config.lib.file.mkOutOfStoreSymlink config.home.mutableFile."dotfiles".path;
  nix-nvim = config.lib.file.mkOutOfStoreSymlink config.home.mutableFile."nix-nvim".path;
in {
  # manage.
  home.username = "charly";
  home.homeDirectory = "/home/charly";
  home.enableNixpkgsReleaseCheck = false;
  fetch-mutable-files.enable = true;
  home.mutableFile = {
    "dotfiles" = {
      url = "https://github.com/carlos-reyes93/dotfiles.git";
      type = "git";
    };
    "nix-nvim" = {
      url = "https://github.com/carlos-reyes93/nix-nvim.git";
      type = "git";
    };
  };
  home.mutableFile = {
  };

  home.stateVersion = "25.11";

  home.packages = [
    pkgs.nerd-fonts.fira-code
    pkgs.fish
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
}
