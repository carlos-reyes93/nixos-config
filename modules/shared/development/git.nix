{
  config,
  lib,
  ...
}: {
  config = {
    home-manager.users.${config.charly.user.name} = {
      programs.git = {
        enable = true;
        userEmail = config.charly.user.email;

        includes = lib.flatten [];
        extraConfig = {
          init.defaultBranch = "main";
          push.autoSetupRemote = true;
          pull.rebase = true;
          safe.directory = "${config.charly.user.homeDirectory}/repos/nixos-config";
        };
      };
    };
  };
}
