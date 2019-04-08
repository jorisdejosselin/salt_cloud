master_file:
  file.managed:
    - name: /etc/salt/master
    - source: salt://saltmaster/files/master
  service.running:
    - name: salt-master
    - restart: True
    - enable: True
    - watch:
      - file: master_file
