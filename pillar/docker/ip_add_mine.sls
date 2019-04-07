mine_functions:
  network.ip_addrs: [eth0]
  id_list:
    - mine_function: grains.get
    - id
  virtmem_list:
    - mine_function: grains.get
    - virtmem
  virtcpu_list:
    - mine_function: grains.get
    - virtcpu
