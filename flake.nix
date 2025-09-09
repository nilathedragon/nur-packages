{
  description = "My personal NUR repository";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ self, flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;

      imports = [
        (
          { inputs, ... }: {
            perSystem = { system, ... }: {
              _module.args = {
                pkgs = import inputs.nixpkgs { inherit system; };
              };
            };
          }
        )
      ];

      flake = {
        nixosModules = {
          default = { config, pkgs, ... }: {
            nixpkgs.overlays = [ self.overlays.default ];
          };
        };
        overlays = {
          default = final: prev: ((import ./default.nix { pkgs = prev; }).overlays.default final prev);
        };
      };
      
      perSystem = { pkgs, system, ... }: {
        packages = import ./default.nix {inherit pkgs;};
      };
    };
}
