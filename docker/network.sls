system:
  network.system:
    - enabled: True
    - hostname: {{ grains['hostname'] }}.jojo.local
    - apply_hostname: True
    - gatewaydev: eth0
    - nozeroconf: True
    - nisdomain: jojo.local
    - require_reboot: True

set_eth0:
  network.managed:
    - name: eth0
    - enabled: True
    - type: eth
    - proto: none
    - ipaddr: {{ grains['ip'] }}
    - netmask: 255.255.255.0
    - gateway: 192.168.178.1
    - dns:
      - 192.168.178.99

restart_network:
  service.running:
    - name: network
    - restart: True
    - enable: True
    - watch:
      - set_eth0

restart_minion:
  service.running:
    - name: salt-minion
    - restart: True
    - enable: True
    - watch:
      - restart_network
