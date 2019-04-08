{% set ip = salt['mine.get']('docker-master*', 'network.ip_addrs', tgt_type='glob') | dictsort() %}
run_compose_file:
  cmd.run:
    - cwd: /root/compose/cloud_opdracht
    {%- for server, addrs in ip %}
    - name: | 
        sleep 10
        docker stack deploy -c docker-compose.yml test
    {%- endfor %}
