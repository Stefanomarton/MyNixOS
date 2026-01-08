{ config, lib, pkgs, modulesPath, ... }:

{
  networking = {
    useNetworkd = false;
    useDHCP = false;

    bridges = {
      br0 = {
        interfaces = [ "enp6s0" ];
        rstp = true;
      };
    };

    # VLANs on br0
    vlans = {
      vlan40 = {
        id = 40;
        interface = "br0";
      };
      vlan10 = {
        id = 10;
        interface = "br0";
      };
      vlan20 = {
        id = 20;
        interface = "br0";
      };
    };

    interfaces = {
      # Optional: management IP on native / untagged br0
      # (NO gateway here)
      br0.ipv4.addresses = [{
        address = "10.1.0.35";
        prefixLength = 24;
      }];

      # VLAN 40 – primary uplink
      vlan40.ipv4.addresses = [{
        address = "192.168.40.35";
        prefixLength = 24;
      }];

      # VLAN 10 – secondary network
      vlan10.ipv4.addresses = [{
        address = "192.168.10.35";
        prefixLength = 24;
      }];

            # VLAN 10 – secondary network
      vlan20.ipv4.addresses = [{
        address = "192.168.1.35";
        prefixLength = 24;
      }];
      
    };
   

    # Default route ONLY on vlan40
    defaultGateway = {
      address = "192.168.40.1";
      interface = "vlan40";
    };

    nameservers = [ "1.1.1.1" "8.8.8.8" ];
  };
}
