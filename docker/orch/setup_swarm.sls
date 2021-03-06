update_mine_pillar:
  salt.function:
    - tgt: 'docker*'
    - name: mine.update

install_docker:
  salt.state:
    - tgt: 'docker*'
    - sls:
      - docker

init_docker-master:
  salt.state:
    - tgt: 'docker-master*'
    - sls:
      - docker.master

update_mine_pillar_thesecond:
  salt.function:
    - tgt: 'docker*'
    - name: mine.update

init_docker-slave:
  salt.state:
    - tgt: 'docker-slave*'
    - sls:
      - docker.slave

push_image:
  salt.state:
    - tgt: 'docker-master*'
    - sls:
      - docker.push_image

pull_image:
  salt.state:
    - tgt: 'docker-slave*'
    - sls:
      - docker.pull_image

run_stack:
  salt.state:
    - tgt: 'docker-master*'
    - sls:
      - docker.stack
