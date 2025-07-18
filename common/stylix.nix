{ config, pkgs, home-manager, ... }: {
  stylix.enable = true;
  stylix.autoEnable = true;
  stylix.polarity = "light";
  stylix.image = ./wallpaper.png;
  stylix.base16Scheme =
    "${pkgs.base16-schemes}/share/themes/black-metal-nile.yaml";
  stylix.targets = {
    gtk.enable = true;
    zathura.enable = true;
    kitty.enable = true;
    kitty.variant256Colors.enable = true;
    hyprland.enable = true;
    hyprpaper.enable = true;
    nushell.enable = true;
    yazi.enable = true;
  };

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;

  services.gammastep = {
    enable = true;
    provider = "manual";
    latitude = 45.1854;
    longitude = 9.1553;
    settings = {
      general = {
        brightness-day = 1.0;
        brightness-night = 0.6;
        adjustment-method = "wayland";
      };
    };
  };
}
