{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-unstable branch here
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
      # Please replace my-nixos with your hostname
      nixosConfigurations = {
        laptop = lib.nixosSystem {
          inherit system;

          modules = [
            # Import the previous configuration.nix we used,
            # so the old configuration file still takes effect
            ./configuration.nix
          ];
          specialArgs = {
            inherit unstable;
          };
        };
      };
    };
}
