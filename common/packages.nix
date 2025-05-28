{
  config,
  pkgs,
  unstable,
  inputs,
  ...
}:
let
  mytexlive = pkgs.texlive.combine { 
    inherit (pkgs.texlive) scheme-full beamertheme-arguelles; 
  };
in
  {

programs.thunderbird.enable = true;


 programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = unstable.hyprland;
    portalPackage = unstable.xdg-desktop-portal-hyprland;
};

programs.zsh.enable = true;
programs.firefox = {
    enable = true;
  };
    
environment.systemPackages =
    (with pkgs; [
      #Editors
      neovim
      neovide
      auctex
      emacs30-pgtk
      emacsPackages.jinx
      enchant
      (aspellWithDicts (
        dicts: with dicts; [
          en
          en-computers
          en-science
          it
        ]
      ))
      hunspell
      hunspellDicts.en_US
      hunspellDicts.it_IT
      plantuml
      mytexlive

      # Terminal and Shell
      kitty
      zoxide
      fzf
      nushell
      carapace

      # Programs
      gparted
      supersonic-wayland
      spotify
      buku
      kdePackages.kdenlive
      freecad

      # Git
      git
      lazygit
      gh

      # Tools
      stow
      exfatprogs
      socat
      libqalculate
      ripgrep
      ripgrep-all
      jq
      busybox
      slurp
      grim
      atool
      caligula
      moar
      kdiskmark

      # Audio
      jamesdsp
      pavucontrol
      pamixer
      playerctl
      cmus
      mpv

      # Productivity
      anki
      zathura
      sioyek
      zotero
      obsidian
      ticktick
      
      jre_minimal
      #rustdesk
      inkscape
      kicad
      ipe
      solaar

      # social
      ferdium

      # DE
      wallust
      imv
      tofi
      eww
      cliphist
      pyprland
      wl-clipboard
      kmonad
      polkit_gnome
      hyprpaper
      gammastep
      xdg-desktop-portal-gtk
      vlc
      xdragon
      peek
      chromium

      #3DPrinting
      prusa-slicer
      orca-slicer

      # Files
      unzip
      zip
      unrar
      atool
      nextcloud-client

      # Appearance
      nemo

      # Programming and compilers
      gnumake
      tree-sitter
      cmake
      gcc
      python3
      pyright
      clang
      nixfmt-rfc-style
      cpio
      meson
      hyprwayland-scanner
      hyprcursor
      taplo
      nodejs_24
      shfmt
      qmk
      pkgsCross.avr.buildPackages.gcc
      avrdude
      pico-sdk
      picotool

      # VM
      OVMFFull
      swtpm
      virt-viewer
      virglrenderer
      looking-glass-client
      remmina

      # GPU
      nvtopPackages.amd

      #LSP
      nixd

   ])

    ++ (with unstable; [
      yazi
      bitwarden
      unstable.btop
      libreoffice-fresh
    ]);
}
