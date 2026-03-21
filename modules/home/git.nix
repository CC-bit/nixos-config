# ~/.config/nixos/modules/home/git.nix
{ pkgs, ... }: {
  # 1. 启用 Git 程序
  programs.git.enable = true;

  # 2. 映射配置文件到家目录
  # 注意：Git 默认读取家目录下的 .gitconfig
  home.file.".gitconfig".source = ../../dotfiles/.gitconfig;
}
