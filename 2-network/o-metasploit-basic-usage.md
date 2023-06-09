# o - Metasploit  Basic Usage

{% code overflow="wrap" lineNumbers="true" %}
```bash
# spawn/execute cmd prompt from a meterpreter session
meterpreter > execute -f cmd.exe -i -H # launch any executable.
meterpreter > search -f password.* # search for all occurence of "password."
meterpreter > edit <file_path> # just like "cat" in linux.
meterpreter > run post/ # tap tab button for more option. you can run modules.
meterpreter > clearev # clear all logs (require admin priv).
```
{% endcode %}
