{
  description = "My NixOS system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dotfiles = {
      url = "path:/home/qqueke/repos/dotfiles";
      flake = false;
    };
  };

  outputs = { nixpkgs, home-manager, dotfiles, ... }:
  let
    system = "x86_64-linux";
    user = "qqueke";

    pkgs = import nixpkgs {
      inherit system;
    };
  in {
    nixosConfigurations.myhost = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        ./configuration.nix

        home-manager.nixosModules.home-manager

        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;

            extraSpecialArgs = {
              inherit dotfiles;
            };

            users.${user} = import ./home.nix;
          };
        }
      ];
    };
  };
}
