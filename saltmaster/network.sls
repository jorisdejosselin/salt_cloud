networkpak:
  pkg.installed:
    - pkgs:
      - ifupdown

system:
  network.system:
    - enabled: True
    - gateway: 192.168.178.1
    - gatewaydev: br0
    - nozeroconf: True

enp8s0:
  network.managed:
    - enabled: True
    - type: eth
    - proto: static
    - ipaddr: 192.168.178.100
    - netmask: 255.255.255.0
    - bridge: br0
    - gateway: 192.168.178.1
    - gatewaydev: br0
    
br0:
  network.managed:
    - enabled: True
    - type: bridge
    - proto: static
    - ipaddr: 192.168.178.100
    - netmask: 255.255.255.0
    - bridge: br0
    - delay: 0
    - ports: enp8s0
    - bypassfirewall: True
    - autoneg: off
    - speed: 1000
    - duplex: full
    - use:
      - network: enp8s0
    - require:
      - network: enp8s0
      - networkpak
    - dns:
      - 8.8.8.8
