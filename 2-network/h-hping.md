# h - Hping

`hping3 -S -p 80 -c 3 $ip` - TCP SYN scan.

`hping3 -S --scan 1-1000 $ip` - scan range of ports,  or (--scan 21,22,23,53) or (--scan all) or (--scan known).

`hping3 -2 --scan 1-1000 $ip` - UDP scan. or specify "--udp".

`hping3 -F -P -U $ip -c 2 -p 80 -V` - mannual XMAS scan (here, ports that do not reply might be considered Open or filtered).

&#x20;`hping3 --scan 1-100 $ip` - NULL Scan

