{
  description = "Nixos config flake";

  inputs = {

     nix-colors.url = "github:misterio77/nix-colors";
     home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
     };
     #hyprland.url = "github:hyprwm/Hyprland";
     nixvim.url = "github:nix-community/nixvim";
     nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

     #inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, nixvim, ... }@inputs: {
    pkgs = import nixpkgs { config = { allowUnfree = true; }; };
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      #specialArgs = {inherit inputs; };
      modules = [
        #nixvim.homeManagerModules.nixvim
        ./configuration.nix

	  home-manager.nixosModules.home-manager
          {

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
	        home-manager.extraSpecialArgs = { inherit inputs; };

            home-manager.users.jack = import ./home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          }
      ];
    };
  };
}
