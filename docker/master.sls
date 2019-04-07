{% set ip = salt['mine.get']('docker-master*', 'network.ip_addrs', tgt_type='glob') | dictsort() %}
{%- set websites = pillar.get('websites') %}
init_swarm:
  module.run:
    - name: swarm.swarm_init
{%- for server, addrs in ip %}
    - advertise_addr: {{ addrs[0] }}
{%- endfor %}
    - listen_addr: '0.0.0.0'
    - force_new_cluster: False
    - unless:
      -  docker node ls

files_compose:
  file.recurse:
    - source: salt://docker/files/compose/
    - name: /root/compose/
    - template: jinja
    - makedirs: True

# create_compose_gitlab:
#   module.run:
#     - name: dockercompose.up
#     - path: /root/compose

docker_ports:
  service.running:
    - name: firewalld
    - reload: True
    - enable: True
  firewalld.service:
    - name: docker
    - ports:
      - 2376/tcp
      - 2377/tcp
      - 2377/tcp
      - 7946/tcp
      - 7946/udp
      - 4789/udp
      - 80/tcp
      - 443/tcp

# set_web_network:
#   docker_network.present:
#     - name: web
#     - driver: overlay
