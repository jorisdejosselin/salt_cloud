# Top file statements
base:
  '*':
    - netdata
    - netdata.slave
  'linius':
    - saltmaster
    - netdata
    - netdata.master
  'docker-master*':
    - docker
  'docker-slave*':
    - docker
  'homeserver':
    - dhcpd
    - bind
    - homeserver
  'nginx':
    - nginx
  'openstack*':
    - openstack
