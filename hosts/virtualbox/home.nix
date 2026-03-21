# ~/.config/nixos/home.nix
{ pkgs, inputs, ... }: {
  imports = [
    ../../modules/home/shell.nix     # 通用 Fish 配置
    ../../modules/home/terminal.nix  # 通用 Alacritty 配置
    ../../modules/home/editor.nix    # 通用 Neovim 配置
    ../../modules/home/git.nix      # git
  ];

  home.username = "dhzp";
  home.homeDirectory = "/home/dhzp";
  home.stateVersion = "23.11";

  home.packages = [
    # Zen Browser (通过 Flake Input 安装)
    inputs.zen-browser.packages."x86_64-linux".default
  ];

  # 告诉 Home Manager 允许它管理自己
  programs.home-manager.enable = true;
}
