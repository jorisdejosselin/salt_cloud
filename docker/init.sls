{% from "docker/map.jinja" import docker with context %}

docker_ports:
  service.running:
    - name: firewalld
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
docker_firewall:
  firewalld.present:
    - name: public
    - services:
      - docker
      - ssh

net.ipv4.ip_forward:
  sysctl.present:
    - value: 1

turn_off_swap:
  cmd.run:
    - name: swapoff -a

unmount_swap:
  mount.unmounted:
    - name: /dev/mapper/centos_centosbase-swap
    - fstype: swap
    - persist: True
    - require:
      - turn_off_swap

install_latest_docker:
  cmd.run:
    - name: |
        {{ docker.docker_repo }}

install_docker_depends:
  pkg.installed:
    - pkgs:
      - python-pip
      - yum-utils
      - device-mapper-persistent-data
      - lvm2
      - docker-ce
      - docker-ce-cli
      - containerd.io

docker:
  pip.installed

docker-compose:
  pip.installed

permissive:
    selinux.mode

add_insecure_reg:
  file.managed:
    - name: /etc/docker/daemon.json 
    - source: salt://docker/files/deamon.json.jinja
    - template: jinja

start_docker_service:
  service.running:
    - name: docker
    - enable: True
    - watch:
      - add_insecure_reg
