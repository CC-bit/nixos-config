# ~/.config/nixos/modules/nvim.nix
{ pkgs, ... }: {
  programs.neovim.enable = true; #
  # 递归地将整个 nvim 文件夹链接到 ~/.config/nvim
  xdg.configFile."nvim" = {
    source = ../../dotfiles/nvim;
    recursive = true;
  };
}
