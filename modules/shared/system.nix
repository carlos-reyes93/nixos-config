{
  config,
  pkgs,
  ...
}: {
  config = {
    nixpkgs.config = {
      allowUnfree = true;
    };
    time.timeZone = config.charly.timeZone;

    programs.fish.enable = true;
    environment.shells = with pkgs; [
      fish
    ];

    environment.variables.EDITOR = config.charly.editor;

    fonts = {
      packages = with pkgs; [
        nerd-fonts.fira-code
      ];
    };

    nix = {
      enable = true;
      package = pkgs.nix;
      settings = {
        trusted-users = [config.charly.user.name];
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        warn-dirty = false;
        auto-optimise-store = true;
      };

      gc = {
        automatic = true;
        dates = ["weekly"];
        options = "--delete-older-than 7d";
      };
    };

    system.stateVersion = config.charly.stateVersion;
  };
}
