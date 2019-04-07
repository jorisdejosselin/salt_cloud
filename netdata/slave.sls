set_netdata_slave:
    file.managed:
        - name: /etc/netdata/stream.conf
        - source: salt://netdata/files/slave_stream.conf

restart_service_slave:
    service.running:
        - name: netdata
        - restart: True
        - watch:
            - set_netdata_slave
