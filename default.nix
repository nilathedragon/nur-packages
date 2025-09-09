# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{ pkgs ? import <nixpkgs> { } }: let
  # pkgsFolder = ./pkgs;
  # entries = builtins.readDir pkgsFolder;

  # flakePackages = 
  #   builtins.listToAttrs
  #   (
  #     builtins.filter (x: x != null)
  #     (
  #       map (
  #         name: if entries.${name} == "directory" && builtins.pathExists (pkgsFolder + "/${name}/default.nix") then {
  #           inherit name;
  #           value = pkgs.callPackage (pkgsFolder + "/${name}") {};
  #         } else null
  #       )
  #       (
  #         builtins.attrNames entries
  #       )
  #     )
  #   );
  flakePackages = {
    frida-dexdump = pkgs.python3.pkgs.callPackage ./pkgs/frida-dexdump { };
  };
in
{
  # The `lib`, `modules`, and `overlays` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays { inherit flakePackages; }; # nixpkgs overlays

  python3Packages = let
    callPackage = pkgs.python3.pkgs.callPackage;
  in pkgs.recurseIntoAttrs {
    wallbreaker = callPackage ./pkgs/python-packages/wallbreaker { };
  };
} // flakePackages
