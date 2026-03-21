# ~/.config/nixos/modules/home/yazi.nix
{ pkgs, ... }: {
  programs.yazi = {
    enable = true;
    # 由于你在 shell.nix 中启用了 fish
    # 这里建议开启集成，以便支持退出 yazi 时自动切换目录功能
    enableFishIntegration = true;
    # 如果你习惯输入 'y' 启动 yazi，可以设置：
    shellWrapperName = "y";
  };

  # 将整个 dotfiles/yazi 文件夹递归链接到 ~/.config/yazi
  xdg.configFile."yazi" = {
    source = ../../dotfiles/yazi;
    recursive = true;
  };

  # mount.yazi 插件依赖 udisks2 和 util-linux (lsblk, eject)
  # 虽然 GNOME 环境通常自带，但显式写在这里更符合 NixOS 的声明式哲学
  home.packages = with pkgs; [
    udisks
    util-linux
  ];
}
