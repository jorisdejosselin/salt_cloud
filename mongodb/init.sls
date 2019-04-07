base:
  pkgrepo.managed:
    - humanname: MongoDB Repository
    - mirrorlist: https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.4/x86_64/
    - gpgcheck: 1
    - gpgkey: https://www.mongodb.org/static/pgp/server-3.4.asc

set_mongo_conf:
    file.managed:
        - name: /etc/mongod.conf
        - source: salt://mongodb/mongod.conf

install_mongodb:
    pkg.installed:
        - pkgs:
            - mongodb
        - watch:
            - set_mongo_conf

