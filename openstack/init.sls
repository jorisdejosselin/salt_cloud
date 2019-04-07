depends:
  pkg.installed:
    - pkgs:
      - git
      - ifupdown

disable_networkmanager:
    service.dead:
        - enable: false
        - name: 
            - NetworkManager
            - firewalld

set_selinux_file:
    file.managed:
        - name: /etc/selinux/config
        - source: salt://openstack/files/selinux.conf

setenforce 0:
    cmd.run

give_nopass_sudo:
  file.managed:
    - name: /etc/sudoers.d/joris
    - source: salt://openstack/files/nopassw.sudo

system:
  network.system:
    - enabled: True
    - hostname: openstack.jojo.local
    - apply_hostname: True
    - gatewaydev: eth0
    - nozeroconf: True
    - nisdomain: jojo.local
    - require_reboot: True

set_ens3:
  network.managed:
    - name: ens3
    - enabled: True
    - type: eth
    - proto: static
    - ipaddr: 192.168.178.150
    - netmask: 255.255.255.0
    - gateway: 192.168.178.1
    - dns:
      - 192.168.178.99
