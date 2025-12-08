{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.matugen.nixosModules.default
  ];

  config = {
    home.packages = [
      inputs.matugen.packages.${pkgs.system}.default
    ];
  };
}
