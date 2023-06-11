# u - SNMP Enumeration 161,162

### \[snmpwalk]

`snmpwalk -h` - using snmpwalk.

`snmpwalk -v 2c -c public $ip` - dumps lots of info.

`snmpwalk -v 2c -c pblic $ip hrSWInstalledName` -   dumps all installed apps in the victim PC.

`snmpwalk -v 2c -c pblic $ip hrMemorySize` -  size of ram.

### \[snmpset]&#x20;

Used to set values within SNMP variables.

`snmpset -v 2c -c public $ip sysContact.0 s els` - change the variable value to "els"

### \[nmap]

`nmap -sU -p161 --script snmp-win32-services $ip` - enumerate windows servicing througn SNMP.

### How to discover the Community String value?

Nmap provides us with a script and a wordlist for this purpose.&#x20;

`nmap -sU -p 161 --script snmp-brute $ip` - tries to get the community string value via bruteforcing.

`nmap -sU -p 161 --script snmp-win32-users $ip`  - returns available users on the machine.
