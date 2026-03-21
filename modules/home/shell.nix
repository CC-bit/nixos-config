# ~/.config/nixos/modules/home/shell.nix
{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    
    # 1. 替代原本的 fish_greeting 函数
    interactiveShellInit = ''
      set -g fish_greeting ""
      
      # 开启 Vi 模式
      fish_vi_key_bindings
      set fish_cursor_default block
      set fish_cursor_insert line
      set fish_cursor_replace_one underscore
      set fish_cursor_visual block

      # 设置原本在 fish_variables 里的 Pure 主题变量
      set -U pure_enable_git true
      set -U pure_color_primary blue
      set -U pure_symbol_prompt ❯
      # ... 你可以按需将 fish_variables 里的 SETUVAR 转化为 set -U
    '';

    # 2. 环境变量设置
    shellInit = ''
      set -gx EDITOR nvim
      set -gx VISUAL nvim
    '';

    # 3. 插件管理 (建议安装 pure 主题插件)
    plugins = [
      {
        name = "pure";
        src = pkgs.fetchFromGitHub {
          owner = "pure-fish";
          repo = "pure";
          rev = "master";
	  sha256 = "sha256-tnWPXXWrz6XlNkXJ3qBA7uCUXy5QSQWCZwCbCy/vUXQ=";
        };
      }
    ];
  };
}
