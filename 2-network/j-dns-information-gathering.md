# j - DNS Information Gathering

### \[nslookup] utility

`nslookup techfashy.com` - basic ip lookup.

`nslookup -query=mx techfashy.com` - MX records lookup.

or `nslookup -q=cname techfashy.com` - for CNAME records, you can specify other records.

### \[dig] utility

`dig techfashy.com` - basic usage.

`dig techfashy.com NS` - for nameserver records.

`dig techfashy.com NS +noall +nocmd +answer` - just return NS without extra gibberish.

`dig +nocmd zonetransfer.me AXFR +noall +answer @nsztm2.digi.ninja.` - perform a dns zonetransfer.&#x20;

### \[fierce] utility

Written in Perl

`fierce --domain zonetransfer.me` - complete dns zonetransfer.

### \[dnsenum]

`dnsenum zonetransfer.me` - full dns zonetransfer.

`dnsenum zonetransfer.me -f <wordlist_path>` - bruteforce&#x20;

### \[dnsmap]&#x20;

This is a Sub-Domain bruteforcer.

`dnsmap zonetransfer.me` - bruteforce for sub domains.

### \[dnsrecon]

`dnsrecon -d zonetransfer.me` - enumerates all zonetransfer records it can find.

