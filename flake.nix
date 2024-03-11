{
  description = "Greg's NixOS configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    username = "greg";

    # Host helper
    mkHost = {
      hostname,
      system,
      extraModules,
    }: let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs username hostname;};
        modules =
          [
            ./hosts/${hostname}
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {inherit inputs username;};
                users.${username} = import ./home/home.nix;
              };
            }
          ]
          ++ extraModules;
      };
  in {
    nixosConfigurations."alpha" = mkHost {
      hostname = "alpha";
      system = "x86-64_linux";
      extraModules = [];
    };
  };
}
