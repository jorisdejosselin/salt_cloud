set_netdata_master:
    file.managed:
        - name: /etc/netdata/stream.conf
        - source: salt://netdata/files/master_stream.conf

restart_service_master:
    service.running:
        - name: netdata
        - restart: True
        - watch:
            - set_netdata_master
