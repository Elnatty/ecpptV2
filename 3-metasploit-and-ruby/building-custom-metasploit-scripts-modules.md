# Building Custom Metasploit Scripts/Modules

Page 113 of the Metasploit.pdf slide.

A useful directory is the `~/.msf4/` . It is suitable for local user modules and plugins. Putting them will allow us have them in the Metasploit framework too.

#### Metasploit Libraries

* REX - ruby exttension library.
* MSF CORE -
* MSF BASE -

## Considerations to take before creating Custom Modules.

1. Identify the module type you want to create. in this case it is an exploitation module to exploit a buffer overflow vulnerabillity of the ELS Echo Server.
2. What platform? in this case, target runs on Windows. This tells us where the real Ruby file module must be stored in order to make it recognizable by the framework. ie, "exploit/windows/els".
3. Where do we put the module in? we have 2 options;

* In the framework file system: /usr/share/metasploit-framework/modules/exploits/windows. or
* In the directory reserved to the private user modules and plugins: \~/.msf4/modules/exploits/windows/. Using the reserved directory is better (prevents and problems related to the framework updates and upgrades ie the overwrite of your custom modules after updating the Metasploit framework). By default the specific dirs are not available, we have to create them. \~/.msf4/modules/exploits/windowws/els.



