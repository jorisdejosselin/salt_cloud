{% set ip = salt['mine.get']('docker-master*', 'network.ip_addrs', tgt_type='glob') | dictsort() %}
pull_images:
  cmd.run:
    {%- for server, addrs in ip %}
    - name: |
        docker pull {{ addrs[0] }}:5000/cloud_opdracht
    {%- endfor %}
