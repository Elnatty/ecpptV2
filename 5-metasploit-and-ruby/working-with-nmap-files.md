# Working with nmap files

### Most used nmap outputs

* `-oN` normal output like .txt
* `-oX` xml format for inporting to Metasploit.
* `-oG` grepable format.

### My bash one-liner cmd to discover hosts in a network

`nmap -sn -n 192.168.0.1/24 --disable-arp-ping | for i in $(grep -Eo "([0-9]{1,3}.){3}[0-9]{1,3}"); do echo "$i is up."; done` .

### Ruby Script to discover hosts in  a network

{% code overflow="wrap" lineNumbers="true" %}
```ruby
File.open(ARGV[0], 'r') do |file|
  for f in file.readlines
    /(?:Nmap scan report for )((?:\d{1,3}.){3}\d{1,3})/.match(f)
    puts $1 # if the pattern matches the line, then $1 is defined and contains the substring that matches the pattern group ((?:\d{1,3}.){3}\d{1,3})
  end
end

# Usage:
# ruby play.rb nmap_scan.txt
```
{% endcode %}

