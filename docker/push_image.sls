{% set ip = salt['mine.get']('docker-master*', 'network.ip_addrs', tgt_type='glob') | dictsort() %}
push_images:
  cmd.run:
    - cwd: /root/compose/cloud_opdracht
    {%- for server, addrs in ip %}
    - name: | 
        docker run -d -p 5000:5000 --restart=always --name registry registry:2
        docker build . -t {{ addrs[0] }}:5000/cloud_opdracht
        docker push {{ addrs[0] }}:5000/cloud_opdracht
    {%- endfor %}
