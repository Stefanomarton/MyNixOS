{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  networking.useNetworkd = true;
  networking.useDHCP = false;
  systemd.network.enable = true;
  networking.networkmanager.enable = false;

  systemd.network.netdevs = {
    "10-br40" = {
      netdevConfig = { Name = "br40"; Kind = "bridge"; };
      bridgeConfig = { STP = false; };
    };

    "11-enp6s0.40" = {
      netdevConfig = { Name = "enp6s0.40"; Kind = "vlan"; };
      vlanConfig = { Id = 40; };
    };
  };

  systemd.network.networks = {
    "10-enp6s0" = {
      matchConfig.Name = "enp6s0";
      networkConfig = { DHCP = "no"; };
    };

    "20-enp6s0.40" = {
      matchConfig.Name = "enp6s0.40";
      networkConfig = {
        Bridge = "br40";
        DHCP = "no";
      };
    };

    # Optional host IP on VLAN 40 (on br40)
    "30-br40" = {
      matchConfig.Name = "br40";
      networkConfig = { DHCP = "ipv4"; };
      # or static address/routes like above
    };
  };
}

