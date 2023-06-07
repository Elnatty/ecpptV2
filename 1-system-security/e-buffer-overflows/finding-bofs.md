# Finding BoF's

Any application that uses unsafe operations such as:

* strcpy, strcat, gets/fgets, scanf/fscanf, vsprintf, memcpy etc.But it actually depends on how the function is used.
* Any function that does not validate inputs before operating and any function that does not check input boundaries.
* BoF can be trigerred by:
  * User input.
  * Data loaded from a disk.
  * Data from the network.
* By using automated tools like: "Splint", "Cppcheck" etc.

### Fuzzing

Fuzing is a software testing technique that provides invalid data, i.e, unexpected or random data as input to a program. Some Fuzzing tools are: Peach Fuzzing Platform, Sulley, Sfuzz, FileFuzz etc.



