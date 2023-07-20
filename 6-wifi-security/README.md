# 4 - Wifi Security

### \[iwconfig] utility

`iwconfig wlan0 channel 11` - sets card wifi channel to 11. `iw dev wlan0 set channel 11` - sets card wifi channel to 11.

### Increasing the Maximum Transmit power

`iw reg set BO` or `iw dev wlan0 set txpower fixed 30dbm` .

### Setting up a virtual env

`airmon-ng start wlan0` - put wifi card in monitor mode. `airmon-ng check kill` - get rid of programs that may cause issues, \`system

`aireplay-ng -9 wlan0mon` - check if packet injection is working.

<figure><img src="../.gitbook/assets/image (44).png" alt=""><figcaption></figcaption></figure>

### Wifi Traffic Analysis

Make sure your wireless card is in monitoring mode (airmon-ng start wlan0). Launch wireshark and sniff on the "wlan0mon" interface.

#### Channel Hopping

This is the technique of constantly switching the channel on which the wireless adapter operates. Obviously, while locked to a specific channel, the wireless adapter still cannot receive frames sent on any others so this technique is mostly useful for recon purposes than to really capture data. As wireshark does not support Channel Hopping, it is not the most appropiate tool for the recon tasks. We will use "airodump-ng". If you have a supported card, you could also hop on more than one wireless band using the "--band" option ie, `airodump-ng --band abg -w <output_file> wlan0mon` - specifing a,b,g.

### Wireshark Filters

`wlan.fc.type_subtype != 0x08` - exclude Beacon frames. `wlan.fc.type == 0x02` - filter by Re-association request.

We can filter for a particular device/AP traffic by using the:

`wlan.fc.type_subtype != 0x08 $$ wlan.bssid == <AP_mac_addr>` - filters for packets/frames for that AP alone.

When you start a new wireshark capture with the above filter option, you begin to see "probe response" coming in from the wifi client trying to discover nearby wireless network availability.

<figure><img src="../.gitbook/assets/image (38).png" alt=""><figcaption></figcaption></figure>

### Traffic Decryption

<figure><img src="../.gitbook/assets/image (42).png" alt=""><figcaption><p>1</p></figcaption></figure>

<figure><img src="../.gitbook/assets/image (46).png" alt=""><figcaption><p>2</p></figcaption></figure>

<figure><img src="../.gitbook/assets/image (43).png" alt=""><figcaption><p>3</p></figcaption></figure>

<figure><img src="../.gitbook/assets/image (33).png" alt=""><figcaption><p>4</p></figcaption></figure>

<figure><img src="../.gitbook/assets/image (48).png" alt=""><figcaption><p>5</p></figcaption></figure>

<figure><img src="../.gitbook/assets/image (36).png" alt=""><figcaption><p>6</p></figcaption></figure>

### Traffic Decryption with Aircrack-ng suite utility

Aircrack-ng suite also offers a decryption tool. It is called "airdecap-ng". It can decrypt WEP, WPA, WPA2 encrypted packets. `airdecap-ng -w <wep_key_in_hex> <output_file_name.cap>` decrypt WEP packets. We can also specify the `-l` flag to disable filtering out all management and control frames. `airdecap-ng -p <wpa_passphrase> -e <SSID> <.cap>` decrypt WPA packets. After this, open the "-dec" file with wireshark for analysis.
