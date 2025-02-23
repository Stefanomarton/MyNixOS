{
  config,
  pkgs,
  unstable,
  inputs,
  ...
}:
{
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

      # Terminal and Shell
      kitty
      zoxide
      fzf
      nushell
      carapace

      # Programs
      gparted
      supersonic-wayland

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

      # Productivity
      anki
      zathura
      sioyek
      zotero
      obsidian
      ticktick
      libreoffice-fresh
      jre_minimal
      #rustdesk
      inkscape

      # social
      ferdium
      telegram-desktop

      # DE
      wallust
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
      texlive.combined.scheme-full
      nixfmt-rfc-style
      cpio
      meson
      hyprwayland-scanner
      hyprcursor
      taplo
      nodejs_23

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

      inputs.zen-browser.packages.${system}.specific
    ])

    ++ (with unstable; [
      yazi
      bitwarden
      unstable.btop
    ]);
}
