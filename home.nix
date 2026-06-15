{ config, pkgs, dotfiles, ... }:

{
  home.username = "qqueke";
  home.homeDirectory = "/home/qqueke";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  # Bash
  programs.bash.enable = true;

  # Bashrc
  programs.bash.bashrcExtra = builtins.readFile "${dotfiles}/bashrc-config/.bashrc";

  # Waybar
  xdg.configFile."waybar".source = "${dotfiles}/waybar-config";

  # Hyprland
  xdg.configFile."hypr".source = "${dotfiles}/hyprland-config";

  # Alacritty
  xdg.configFile."alacritty".source = "${dotfiles}/alacritty-config";
}
