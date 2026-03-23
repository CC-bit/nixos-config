# modules/home/paperwm.nix
{ config, pkgs, lib, ... }:

{
  home.packages = [ pkgs.gnomeExtensions.paperwm ];

  dconf.settings = {
    # 主配置路径
    "org/gnome/shell/extensions/paperwm" = {
      cycle-width-steps = [ 0.38195 0.5 0.75 ];
      horizontal-margin = 0;
      last-used-display-server = "Wayland";
      # 注意：在 Nix 中，布尔值直接写 true/false，不需要加引号
      restore-attach-modal-dialogs = true; 
      restore-edge-tiling = true;
      restore-workspaces-only-on-primary = true;
      
      # 这一段是 PaperWM 自动备份的 JSON，保留原样字符串即可
      restore-keybinds = ''
        {"cancel-input-capture":{"bind":"[\\"<Super><Shift>Escape\\"]","schema_id":"org.gnome.mutter.keybindings"}, ... (省略中间内容) ... }
      '';

      selection-border-radius-bottom = 15;
      selection-border-radius-top = 15;
      selection-border-size = 1;
      show-window-titles = true;
      use-selected-index-bar = true;
      vertical-margin = 0;
      vertical-margin-bottom = 0;
      window-gap = 2;
    };

    # 快捷键子路径
    "org/gnome/shell/extensions/paperwm/keybindings" = {
      center-vertically = [ "" ];
      close-window = [ "<Super>q" ];
      cycle-height-backwards = [ "" ];
      cycle-width-backwards = [ "" ];
      drift-left = [ "" ];
      drift-right = [ "" ];
      switch-down = [ "<Super>j" ];
      switch-left = [ "<Super>h" ];
      switch-next = [ "" ];
      switch-previous = [ "" ];
      switch-right = [ "<Super>l" ];
      switch-up = [ "<Super>k" ];
    };

    # 工作区子路径
    "org/gnome/shell/extensions/paperwm/workspaces" = {
      list = [ "bd8dedd9-c6f3-42a1-850f-eeae48f6eb03" "28af03cf-6ac4-48f3-bd5e-d76c101acb0f" ];
    };

    "org/gnome/shell/extensions/paperwm/workspaces/28af03cf-6ac4-48f3-bd5e-d76c101acb0f" = {
      index = 1;
    };

    "org/gnome/shell/extensions/paperwm/workspaces/bd8dedd9-c6f3-42a1-850f-eeae48f6eb03" = {
      index = 0;
      show-position-bar = true;
      show-top-bar = true;
    };
  };
}
