{config, pkgs, ...}:
{
  home.username = "sm";
  home.homeDirectory = "/home/sm/";
  stylix.enable = true;
  stylix.autoEnable = false;
  stylix.polarity = "dark";
  stylix.image = ./wallpaper.png;
  stylix.targets = {
    gtk.enable = true;
    # kitty.enable = true;
  };
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
