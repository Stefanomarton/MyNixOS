{
  config,
  pkgs,
  unstable,
  inputs,
  stylix,
  ...
}:
{
  stylix.enable = true;
  stylix.autoEnable = false;
  stylix.polarity = "dark";
  stylix.image = ./wallpaper.png;
  # stylix.targets = {
  #   # firefox.enable = true;
  #   # kitty.enable = true;
  # };
}
