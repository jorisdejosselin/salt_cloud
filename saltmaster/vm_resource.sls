{%- set virtmems = salt['mine.get']('host:*', 'virtmem_list', tgt_type='grain') | dictsort() %}
{%- set virtcpus = salt['mine.get']('host:*', 'virtcpu_list', tgt_type='grain') | dictsort() %}
              
{%- for name,mem in virtmems %}
stop_{{ name }}:
    cmd.run:
        - name: |
            virsh shutdown {{ name }}

waitfordown_{{ name }}:
    cmd.run:
        - name: |
            for i in {1..5}
            do
            salt '{{ name }}' test.ping
            if [ $? -eq 1 ]
            then
                break 
            fi
            done
        - reguire:
            - stop_{{ name }}

set_{{ name }}_memory_{{ mem }}:
    cmd.run:
        - name: |
            virsh setmaxmem {{ name }} {{ mem }}G --config
            virsh setmem {{ name }} {{ mem }}G --config
{% endfor %}
{%- for name,cpu in virtcpus %}
set_{{ name }}_cpu_{{ cpu }}:
    cmd.run:
        - name: |
            virsh setvcpus {{ name }} {{ cpu }} --maximum --config
            virsh setvcpus {{ name }} {{ cpu }} --config
start_{{ name }}:
    cmd.run:
        - name: |
            virsh start {{ name }}

waitforup_{{ name }}:
    cmd.run:
        - name: |
            for i in {1..5}
            do
            salt '{{ name }}' test.ping
            if [ $? -eq 0 ]
            then
                break 
            fi
            done
        - reguire:
            - start_{{ name }}
{% endfor %}
