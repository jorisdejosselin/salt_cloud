{% set ip = salt['mine.get']('docker-master*', 'network.ip_addrs', tgt_type='glob') | dictsort() %}
run_compose_file:
  cmd.run:
    - cwd: /root/compose/cloud_opdracht
    {%- for server, addrs in ip %}
    - name: | 
        docker volume create --driver local --opt type=nfs --opt o=nfsvers=4,addr={{ addrs[0] }},rw --opt device=:/root/mongodata mongodbdata
        docker run -d -p 5000:5000 --restart=always --name registry registry:2
        docker build . -t {{ addrs[0] }}:5000/cloud_opdracht
        docker push {{ addrs[0] }}:5000/cloud_opdracht
        docker stack deploy -c docker-compose.yml test
        docker stack rm test
        docker stack deploy -c docker-compose.yml test
    {%- endfor %}
        
