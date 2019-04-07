bind:
  configured_zones:
    jojo.local:
      type: forward
      notify: False
      forwarders:
        - 8.8.8.8
      allow-update: "key core_dhcp"
  available_zones:
    jojo.local:
      file: jojo.local.txt
      soa:
        ns: homeserver.jojo.local                       # Required
        contact: hostmaster.jojo.local           # Required
        serial: 2018041001                        # Required
      records:                                    # Records for the zone, grouped by type
        A:
          homeserver: 192.168.178.100
