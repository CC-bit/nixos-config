# nixos/modules/home/gh.nix
{ pkgs, ... }: {
  programs.gh = {
    enable = true;
    settings = {
      # 直接在这里写配置，不需要单独的 config.yml 文件
      editor = "nvim";
      git_protocol = "ssh";
      prompt = "enabled";
      # 你可以把之前的别名也写在这里
      aliases = {
        co = "pr checkout";
        pv = "pr view";
      };
    };
  };
}
