# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  unstable,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 0;
  };

  networking.hostName = "desktop";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable polkit
  security.polkit.enable = true;
  services.dbus.enable = true;
  services.gnome.gnome-keyring.enable = true;

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "always";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
    extraConfig = ''
      DefaultTimeoutStopSec=10s
    '';
  };

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
  };

  # Configure console keymap
  console.keyMap = "us-acentos";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sm = {
    isNormalUser = true;
    description = "Stefano Marton";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "input"
      "uinput"
    ];
    packages = with pkgs; [ ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.hyprland = {
    # or wayland.windowManager.hyprland
    enable = true;
    xwayland.enable = true;
    package = unstable.hyprland;
    portalPackage = unstable.xdg-desktop-portal-hyprland;
  };

  programs.zsh.enable = true;

  virtualisation.libvirtd = {
    enable = true;

    # Enable TPM emulation (optional)
    qemu = {
      package = unstable.qemu;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        packages = [
          (unstable.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd
        ];
      };
    };
  };

  # Enable USB redirection (optional)
  virtualisation.spiceUSBRedirection.enable = true;

  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 sm qemu-libvirtd -"
  ];

  programs.virt-manager.enable = true;

  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.hyprland}/bin/Hyprland";
        user = "sm";
      };
      default_session = initial_session;
    };
  };

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  services.blueman.enable = true;

  hardware.bluetooth.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    # extraPackages = [ pkgs.rocmPackages.clr.icd ];
  };
  
  hardware.amdgpu.opencl.enable = true;
  
  hardware.amdgpu.amdvlk.enable = true;

  services.ollama = {
    enable = true;
    acceleration = "rocm";
    environmentVariables = {
    HCC_AMDGPU_TARGET = "gfx1031"; # used to be necessary, but doesn't seem to anymore
    HSA_OVERRIDE_GFX_VERSION = "10.3.0";
  };
  rocmOverrideGfx = "10.3.1";
  };

  services.open-webui.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages =
    (with pkgs; [
      #Editors
      neovim
      auctex
      emacs29-pgtk
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

      # Terminal and Shell
      kitty
      zoxide
      fzf
      nushell
      carapace

      # Programs
      firefox
      gparted
      spotify
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
      wireguard-tools
      caligula

      # Audio
      jamesdsp
      pavucontrol
      pamixer

      # Productivity
      anki
      zathura
      zotero
      obsidian
      ferdium
      ticktick
      libreoffice-fresh
      rustdesk

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

      # Files
      unzip
      zip
      unrar
      atool
      nextcloud-client

      # Programming and compilers
      gnumake
      tree-sitter
      cmake
      gcc
      python3
      clang
      texlive.combined.scheme-full
      nixfmt-rfc-style
      cpio
      meson
      hyprwayland-scanner

      # VM
      OVMFFull
      swtpm
      virt-viewer
      virglrenderer
      looking-glass-client

      # GPU
      nvtopPackages.amd

      #LSP
      nixd
    ])

    ++ (with unstable; [
      nemo
      yazi
      bitwarden
      unstable.btop
    ]);

  fonts.packages = with pkgs; [
    julia-mono
    nerdfonts
  ];

  system.stateVersion = "24.05"; # Did you read the comment?

}
