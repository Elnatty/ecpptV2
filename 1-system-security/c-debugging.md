# Debugging

## Immunity Debugger has 4 Panels

<figure><img src="../.gitbook/assets/Screenshot from 2023-06-02 15-32-18.png" alt=""><figcaption></figcaption></figure>

## Panel 1 - Disassembler Panel

Here is where all the Assembler code is produces or viewed when your are debugging a module.

Here is where all the Assembler code is produces or viewed when your are debugging a module.

* In the 1st column is the Address Location.
* In the 2nd column is the Machine Code.
* In the 3rd column is the Assembly Language.
  * **PUSH**, **MOV**, **CALL**, **POP**, **RETN** etc.
* In the 4th column is the Debugger Comments.

## Panel 2 - Register Panel

This holds information on standard registers.

* Names of registers.
* Their Contents.
* If a register points to an ASCII string, the value of the string.
* As the program progresses and registers are changed or updated, it is easily noted and observed in this panel.

## Panel 3 - The Memory Dump

This panel show the memory locations and relative contents in multiple formats (i.e. hex, UNICODE, etc.).

## Panel 4 - The Stack Panel

This panel shows the Current Thread Stack.

* in the 1st column is the Addresses.
* In the 2nd column is the value on the stack at that address.
* In the 3rd column is an an explanation of the content (if it's an address or a UNICODE string. etc.)
* In the 4th column is the Debugger comments.



## Hacking a C application with Immunity Debugger

### Step 1

I wrote a C program that checks user input for correct password, if user enters correct password, he is greeted with "Welcome User" else "Invalid Password".

Here is the code, saved into a "hello.c" file.

{% code overflow="wrap" lineNumbers="true" %}
```c
#include<stdio.h>

int main()
{
char cpass[10]="Dking";
char upass[10];

printf("enter your name: ");
scanf("%s", upass);

if (strcmp(cpass, upass) == 0){
	printf("Welcome User..");
} else
	printf("Invalid Password\nTry again..");

}
```
{% endcode %}

### Step 2

We use the "x86\_64-w64-mingw32-gcc.exe" compiler which is a 32bit compiler since Immunity Debugger is a 32bit application. This binary is located in the "Dev-C/C++" IDE bin folder for Windows. After compiling into "hello.exe", load it in Immunity Debugger.

### Step 3

In the 1st Panel (Disassembler Panel) right click on any line, then click "Search for", then "All referenced text srtrings", double click the "Invalid Password" text.&#x20;

From here, we can see that the "strcmp" function which compares 2 strings if they are the same or not, is being called, then if the user input is not same with the default password you get an Invalid Password.

<figure><img src="../.gitbook/assets/Screenshot from 2023-06-02 18-18-36.png" alt=""><figcaption></figcaption></figure>

### Step 4

Now the trick here is to replace the "strcmp" function with "NOPs" so that the app wont check but just  authenticate whatever the user inputs and grants him/her access.

So we highlight from the "strcmp" function line down to before the "Welcome User" line.

<figure><img src="../.gitbook/assets/Screenshot from 2023-06-02 18-23-35.png" alt=""><figcaption></figcaption></figure>

Now we right click, select "Binary", then click "Fill with NOPs"

Thats all.

### Step 5

Time to compile the Hacked .exe file back.

Right click same Panel 1, click "Copy to Executable", then click "All modification".

Click "copy all", right click the window, click "Save file" then give a name.

END!!
