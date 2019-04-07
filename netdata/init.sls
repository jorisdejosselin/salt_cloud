netdata_ports:
  firewalld.service:
    - name: netdata
    - ports:
      - 19999/tcp
      - 19999/udp
netdata_firewall:
  firewalld.present:
    - name: public
netdata_firewall_service:
    service.running:
        - name: firewalld
        - restart: True
        - enable: True
        - watch:
            - netdata_ports

install_depends:
    pkg.installed:
        - pkgs:
            - python-pymongo
            - autoconf-archive

salt://netdata/files/install.sh:
    cmd.script
