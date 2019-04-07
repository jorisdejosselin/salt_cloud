base:
  'linius':
    - deploy
  'homeserver':
    - network_tools/dhcp
    - network_tools/dns
  'database':
    - database_*
  'docker*':
    - docker/ip_add_mine
    - docker/get_token_mine
    - docker/websites
  'nginx':
    - docker/websites
