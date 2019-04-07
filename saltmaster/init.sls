salt:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - match: state
    - connstate: NEW
    - dport: 
      - 4505
      - 4506
      - 22
      - 8082
    - protocol: tcp
    - sport: 1025:65535
    - save: True

pypak:
  pkg.installed:
    - pkgs:
      - python-pygit2
      - python-flask
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
deploy_file:
  file.managed:
    - name: {{ pillar['saltmaster_deploydir'] }}
    - source: salt://templates/deploy.py.jinja
    - template: jinja
deploy:
  file.managed:
    - name: /lib/systemd/system/deploy.service
    - source: salt://templates/deploy.service.jinja
    - template: jinja
  module.run:
    - name: service.systemctl_reload
    - reload: True
    - enable: True
    - onchanges:
      - file: deploy
deploy_service:
  service.running:
    - name: deploy
    - reload: True
    - enable: True
    - watch:
      - module: deploy
