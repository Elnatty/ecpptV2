# d - Decompiling

There are different tools that allows us to do this. In the same Dev-C++ folder where the "gcc" executable is located, is a file called "objdump.exe".

* The purpose of this file is to disassemble executable programs.
* File: HelloStudents.exe (file we compiled earlier).
* Command to decompile:
  * `objdump -d -Mintel HelloStudents.exe > disasm.txt` &#x20;
* Switched: -d - tells the tool to disassemble the input file, -Mintel - is a disassembler option that allows us to select disassembly for the given architecture (intel in our case).
