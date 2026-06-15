{ config, pkgs, lib, dotfiles, ... }:

{
  home.username = "qqueke";
  home.homeDirectory = "/home/qqueke";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  # Bash - disable automatic management so we can use copied dotfiles
  programs.bash.enable = false;

  home.activation.copyDotfiles = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "$HOME/.config/waybar"
    rm -rf "$HOME/.config/waybar"/*
    cp -r "${dotfiles}/waybar-config/." "$HOME/.config/waybar/"
    chmod -R u+w "$HOME/.config/waybar"

    mkdir -p "$HOME/.config/hypr"
    rm -rf "$HOME/.config/hypr"/*
    cp -r "${dotfiles}/hyprland-config/." "$HOME/.config/hypr/"
    chmod -R u+w "$HOME/.config/hypr"

    mkdir -p "$HOME/.config/alacritty"
    rm -rf "$HOME/.config/alacritty"/*
    cp -r "${dotfiles}/alacritty-config/." "$HOME/.config/alacritty/"
    chmod -R u+w "$HOME/.config/alacritty"

    rm -f "$HOME/.bashrc"
    cp "${dotfiles}/bashrc-config/.bashrc" "$HOME/.bashrc"
    chmod u+w "$HOME/.bashrc"
  '';

  home.file.".profile".text = ''
    if [ -z "$WAYLAND_DISPLAY" ] && [ -z "$DISPLAY" ] && [ -t 0 ]; then
      exec "$HOME/.config/hypr/starthypr.sh"
    fi
  '';
}
