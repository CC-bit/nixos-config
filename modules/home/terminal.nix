# ~/.config/nixos/modules/alacritty.nix
{ pkgs, ... }: {
  programs.alacritty.enable = true; #
  # 告诉 Home Manager：去 dotfiles 目录找我的原始配置文件
  xdg.configFile."alacritty/alacritty.toml".source = ../../dotfiles/alacritty/alacritty.toml;
}
