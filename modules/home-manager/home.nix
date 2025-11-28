{
  config,
  lib,
  pkgs,
  ...
}:
let
  dotfiles = config.lib.file.mkOutOfStoreSymlink config.home.mutableFile."dotfiles".path;
in
{
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
  };

  home.stateVersion = "25.11";

  home.packages = [
    pkgs.hello
    pkgs.nerd-fonts.fira-code
    pkgs.lua-language-server
    pkgs.stylua
    pkgs.fish
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;

  programs.starship = {
    enable = true;
  };
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      lua-language-server
      rust-analyzer
      gopls
      stylua
    ];

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
    nvim.source = "${dotfiles}/nvim";
    fish.source = "${dotfiles}/shell/fish";
    "starship.toml".source = "${dotfiles}/shell/starship/starship.toml";
  };

}
