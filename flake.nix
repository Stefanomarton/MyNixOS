{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix/release-25.05";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      stylix,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
      unstable = nixpkgs-unstable.legacyPackages.${system};
    in
    {

      nixosConfigurations = {
        laptop = lib.nixosSystem {
          inherit system;

          modules = [
            ./hosts/laptop/configuration.nix
            ./common/packages.nix

            # make home-manager as a module of nixos
            # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.backupFileExtension = "backup";
              home-manager.useUserPackages = true;
              home-manager.users.stefanom = { ... }: {
                imports = [
                stylix.homeModules.stylix
                  ./common/stylix.nix

              ];
             };
              }
          ];

          specialArgs = {
            inherit unstable;
            inherit inputs;
          };
        };

        desktop = lib.nixosSystem {
          inherit system;

          modules = [
            ./hosts/desktop/configuration.nix
            ./common/packages.nix
        
            # make home-manager as a module of nixos
            # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
            home-manager.nixosModules.home-manager
            {
              home-manager = {
              useGlobalPkgs = true;
              backupFileExtension = "backup";
              useUserPackages = true;
              users.sm = { ... }: {
                imports = [
                stylix.homeModules.stylix
                  ./common/stylix.nix
              ];
              };
              extraSpecialArgs = {
                inherit inputs;
                inherit unstable;
              };
              };
            }
          ];

          specialArgs = {
            inherit unstable;
            inherit inputs;
          };
        };
      };
    };
}
