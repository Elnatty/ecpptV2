# c - AV/FW Evasion Techniques

* Fragmentation
* Decoys
* Timing
* Source Ports

#### 1 - Fragmentation

This is the process of spliting a single packet into smaller ones. `nmap sS -f <target_Ip>` Fragmentation does not work with: `-sT` - TCP connect scan and `sV` - Version Detection.

<figure><img src="../../.gitbook/assets/image (50).png" alt=""><figcaption></figcaption></figure>

#### 2 - Decoy

This is to add noise to the IDS by sending scans from spoofed ip addresses. Note: All decoy ips must be up and running. `nmap -sS -D <decoyIP1>, <decoyIP2>, <decoyIP3>, ME, <targetIP>` - `ME` is our own ip addr. Note: you can not use the Decoy attack with `-sT` and `-sV` those uses full connect scan.

<figure><img src="../../.gitbook/assets/image (39).png" alt=""><figcaption></figcaption></figure>

#### 3 - Timing

Timing does not modify the way the packet is forged. The only purpose here is to slow down the scan in order to blend with other traffic in the logs of the FW/IDS. `nmap -sS -T[0~5] [target]` `nmap -sS <targetIP> -T2 -p 22,23,135,445,443 --max-retries 1`

#### 4 - Source Ports

This is used to abuse poorly configured FW that allow traffice from certain ports. eg; from 53 (DNS) or 20 (FTP). We can then change our source port in order to bypass this restriction. `nmap -sS --source-port 53 [target] -p80` or `-g` .
