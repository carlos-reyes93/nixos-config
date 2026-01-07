{
  config,
  lib,
  ...
}: {
  options.charly.services.sshd = {
    enable = lib.mkEnableOption "OpenSSH daemon";
  };

  config = lib.mkMerge [
    (lib.mkIf (config.charly.isLinux && config.charly.services.sshd.enable) {
      services.openssh = {
        enable = true;
        settings = {
          PasswordAuthentication = false;
          PermitRootLogin = "prohibit-password";

          # Remove stale sockets
          StreamLocalBindUnlink = "yes";
        };

        hostKeys = [];
      };
    })
  ];
}
