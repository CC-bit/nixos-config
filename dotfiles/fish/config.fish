source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
function fish_greeting
    #    # smth smth
end

# set default editor
set -gx EDITOR nvim
set -gx VISUAL nvim

# vi mod
if status is-interactive
    # 开启 fish 的 vi 模式
    fish_vi_key_bindings

    # 可选：自定义光标形状随模式改变（需要终端支持）
    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_cursor_replace_one underscore
    set fish_cursor_visual block
end
