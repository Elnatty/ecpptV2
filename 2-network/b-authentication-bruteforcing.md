---
description: you can use the SecLists wordlists
---

# b - Authentication Bruteforcing

### \[ncrack]

`ncrack -vv -U <username_wl> -P <passw_wl> $ip -p telnet` - bruteforce telnet (there may be false positives).

`ncrack -vv -U <username_wl> -P <passw_wl> $ip -p ssh`  - ssh bruteforce.

### \[medusa]

`medusa -h $ip -M ssh -U <username.lst> -P <pass.lst>` - ssh bruteforce.

### \[hydra]

`hydra -L <un.list> -P <pw.list> ssh://$ip` - ssh bruteforce.

`hydra -L <un.list> -P <pw.list> ssh://$ip -T 55` - increasing threads to 55.

### \[patator]

`nano /usr/bin/patator` - view the help menu.

`patator -h` - to also view help menu.

`patator ssh_login -h` - pick an option for more helpl options.

`patator ftp_login host=$ip user=FILE0 password=FILE1 0=<username.wlist> 1=<passw.wlist> -x ignore:mesg="Login incorrect."` - full command for bruteforce.

`patator ssh_login host=$ip user="admin" password="admin1234"` -&#x20;







