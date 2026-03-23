# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: {
  imports = [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/system/i18n.nix       # 抽离出的输入法模块
  ];

  # system configration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.resumeDevice = "/dev/disk/by-label/swap";
  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = "nixos-qemu"; # Define your hostname.    

  fonts.packages = with pkgs; [
    # JetBrains Mono (Nerd Font 版本，包含图标)
    nerd-fonts.jetbrains-mono

    # 文泉驿 (中文字体)
    wqy_zenhei
    wqy_microhei
  ];

  time.timeZone = "Asia/Shanghai"; # Set your time zone.
  # Select internationalisation properties.
  i18n.defaultLocale = "zh_CN.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_MONETARY = "zh_CN.UTF-8";
    LC_NAME = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_TELEPHONE = "zh_CN.UTF-8";
    LC_TIME = "zh_CN.UTF-8";
  };
  
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "cn";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # 启用 QEMU Guest Agent 和 Spice 支持
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
 
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

  # user&app
  users.users.dhzp = {
    isNormalUser = true;
    description = "dhzp";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };
  
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  programs.fish.enable = true;
  
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # 启用 nh 模块
  programs.nh = {
    enable = true;
    # 告诉 nh 你的 flake 配置在哪里，这样以后只需要运行 `nh os switch`
    flake = "/home/dhzp/.config/nixos"; # 请修改为你实际的 flake 存放路径
    # 可选：配置自动清理旧的系统版本
    clean = {
      enable = true;
      extraArgs = "--keep-since 4d --keep 3"; # 保留最近4天的版本，或至少保留3个版本
    };
  };

  # nh 的运行依赖于 nix-output-monitor 和 nvd (用于显示更新差异)
  # 虽然 programs.nh 会自动处理一部分，但建议把它们也显式加上
  environment.systemPackages = with pkgs; [
    nix-output-monitor
    nvd
    spice-vdagent
  ];

  # 3. 定义一个系统级的“用户服务” (Systemd User Service)
  # 这会强制在每个用户登录图形界面时启动剪贴板代理
  systemd.user.services.spice-vdagent = {
    description = "Spice session guest agent (Clipboard sharing)";
    # 确保在图形界面准备好后再启动
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      # -x 参数非常重要：它能解决很多 Wayland/X11 混合环境下的连接问题
      ExecStart = "${pkgs.spice-vdagent}/bin/spice-vdagent -x";
      Restart = "on-failure";
    };
  };

  # 1.5x resolution
  # 1. 确保 dconf 已启用（通常启用 GNOME 时会自动开启，但建议显式声明）
  programs.dconf.enable = true;
  # 2. 系统级 GSettings 覆盖
  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
    [org.gnome.mutter]
    experimental-features=['scale-monitor-framebuffer']
    [org.gnome.settings-daemon.plugins.xsettings]
    overrides={'Gdk/WindowScalingFactor': <2>}
  '';
}
