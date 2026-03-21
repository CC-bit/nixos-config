# ~/.config/nixos/modules/home/yazi.nix
{ pkgs, ... }: {
  programs.yazi = {
    enable = true;
    # 开启 Fish 终端集成，方便使用 yazi 退出时自动 cd 到当前目录的功能
    enableFishIntegration = true; 
  };

  # 递归地将整个 yazi 文件夹链接到 ~/.config/yazi
  xdg.configFile."yazi" = {
    source = ../../dotfiles/yazi;
    recursive = true;
  };
}
