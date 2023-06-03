---
description: c++ program
---

# Buffer Overflows with Immunity Debugger

### Step 1

Launch Immunity Debugger and load the .cpp file. I used the "32bit g++" compiler in the "Dev-C/C++" IDE bin folder, so that immunity debugger can recognize the .cpp program.

### Step 2

We need to provide our input before starting the application.

click the "Debug" tab menu, then "Arguments", we then type some "AAAAAAA" characters in. We have to restart the program for the changes to take place, click the "restart" button.

### Step 3

We need to find the main entry point to the program by viewing the source code and analysing it. From the source code we saw that the "int main" function executes the string "printf("You are in goodpwd.exe now\n");&#x20;

We go back to immunity, and run the program, then right click inside the 1st panel, click "Search for", then "All referenced text String", now we can double click on the "You are in goodpwd.exe now\n" string and this takes us to the Disassembled section where the string is defined.

We can see that Immunity now identiies the entire function in a vertical line.  We can also verify that we are at the exact position we want by comparing the address value we got from when we disassembled the .exe program with "objdump.exe" with the main function address immunity shows us, which is the MAIN ENTRY POINT.

### Step  4

We can set a Break-Point at the begining of the "main function" by hitting "f2" key, run the program with "f9" it should run and stop at the Break-Point set.&#x20;

We are at the 1st instruction of the "main" function ie, <"You are in goodpwd.exe"> The \[EIP] value in the 2nd Panel (registers panel)  points exactly to the 1st instruction.

We click the \<step over> button to step over to the <"password=0"> the 1st line of code in the "int main" function.

Now our main focus is on the "bf\_overflow" function which sets "password=1" then calls the <"good\_password"> function which we are interested in.

Since we are interested in the "bf\_overflow" CALL, We set a break-point at that spot. Then we click the "step into" button to inspect the "bf\_overflow" function.

BUT, befor stepping into the function, lets note the current stack, in the 4th Panel, we see the RETURN address there, this is where we will return once the buffer overflow function ends, to check where that address points, we right click on it and select "Follow in Dissasembler" it take us back to the 1st Panel where we see the next instruction right after the call to the function where we currently are. That is the value that will be restored in the \[EIP]. Let us continue with our program.







