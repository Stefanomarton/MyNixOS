# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;
  hardware.keyboard.qmk.enable = true;

  boot.initrd.availableKernelModules = [
    "amdgpu"
    "vfio-pci"
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [
    "vfio_pci"
    "vfio_iommu_type1"
    "vfio"
  ];
  boot.kernelModules = [ "kvm-amd" "iwlwifi"];
  boot.kernelParams = [
    "quiet"
    "splash"
    "udev.log_level=3"
    "amd_iommu=on"
    "iommu=pt"
    "vfio-pci.ids=1002:67df,1002:aaf0"
    "disable_11ax=Y"
    "power_save=0"
    "iwlmvm.power_scheme=2"
  ];
  
  boot.blacklistedKernelModules = [
    "ucsi_ccg"
  ];
  boot.extraModulePackages = [ ];

  boot.initrd.verbose = false;
  boot.consoleLogLevel = 0;

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/ce5b1cc9-77ec-4c27-af91-9ee79d6b76f9";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/1C9B-FFE6";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/80c04392-ec38-4893-9936-36ded8e2a0c1";
    fsType = "btrfs";
    options = [ "subvol=@home" ];
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp6s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp7s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
