{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
      unstable = nixpkgs-unstable.legacyPackages.${system};
    in {
      
      nixosConfigurations = {
        laptop = lib.nixosSystem {
          inherit system;

          modules = [
            ./configuration.nix
          ];
          
          specialArgs = {
            inherit unstable;
          };
        };
      };
    };
}
