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
    # 使用 nixosConfigurations 定义多台机器
    nixosConfigurations = {
      # 机器 1: 之前的 VirtualBox 配置
      # 建议这里的名字与 hosts/virtualbox/configuration.nix 里的 networking.hostName 一致
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/virtualbox/configuration.nix # 指向 VirtualBox 的配置
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.dhzp = import ./hosts/virtualbox/home.nix;
          }
        ];
      };
      # 机器 2: 现在的 QEMU 配置
      # 名字对应 hosts/qemu/configuration.nix 里的 networking.hostName = "nixos-qemu"
      nixos-qemu = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/qemu/configuration.nix # 指向 QEMU 的配置
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.dhzp = import ./hosts/qemu/home.nix;
          }
        ];
      };

      # 如果以后有新机器（比如笔记本），直接在这里按样板添加即可
    };
  };
}
