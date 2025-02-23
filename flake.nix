{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    zen-browser.url = "github:MarceColl/zen-browser-flake";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix/release-24.11";
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
                stylix.homeManagerModules.stylix
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
              home-manager.useGlobalPkgs = true;
              home-manager.backupFileExtension = "backup";
              home-manager.useUserPackages = true;
              home-manager.users.sm = { ... }: {
                imports = [
                stylix.homeManagerModules.stylix
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
      };
    };
}
