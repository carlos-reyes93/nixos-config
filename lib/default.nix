{pkgs, ...}: {
  charly = {
    isDarwin = pkgs.stdenv.isDarwin;
    isLinux = pkgs.stdenv.isLinux;
  };
}
