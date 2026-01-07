{
  config,
  pkgs,
  inputs,
  ...
}: {
  config = {
    # System Wide Packages
    environment.systemPackages = with pkgs; [
      wget
      curl
      coreutils
      unzip
      openssl
      dnsutils
      nmap
      util-linux
      whois
      moreutils
      git
      age
      sops
      ssh-to-age
      tcpdump
      nvd
      tree
    ];

    # User Packages
    home-manager.users.${config.charly.user.name} = {
      home = {
        packages = with pkgs; [
          tlrc
          fontconfig
          fd
          jq
          yq
          direnv
          atac
          comma
          autojump
          inputs.nix-nvim.packages.${stdenv.hostPlatform.system}.nvim
          cloudflared
        ];
      };
    };
  };
}
