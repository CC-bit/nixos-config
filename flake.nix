# ~/.config/nixos/flake.nix
{
  description = "NixOS Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Zen Browser 的 Flake 源
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # 强制 zen-browser 使用你定义的 nixpkgs，避免生成 nixpkgs_2
      inputs.nixpkgs.follows = "nixpkgs";
      # 强制 zen-browser 使用你定义的 home-manager，避免生成 home-manager_2
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { self, nixpkgs, home-manager, zen-browser, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/virtualbox/configuration.nix # 指向机器特定配置
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.dhzp = import ./hosts/virtualbox/home.nix;
        }
      ];
    };
  };
}
