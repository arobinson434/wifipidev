# WiFi Pi Dev Project
This repo houses the external configs and packages for my basic buildroot + WiFi
development setup for raspberry pi. Ie, to develop *over* WiFi, NOT to do dev
work *for* WiFi.

In general, I don't want to faff with UART for I/O, and I don't want to re-flash
my SD card to push dev apps to my pi for testing. I just want to use SSH for I/O
and SCP for file transfer. To facilitate that workflow, I want my pi to start,
join my WiFi network, pull an IP over DHCP, start SSHD, and display the leased
IP on an OLED display.

It is my intention that other RPI projects I have will probably start with this
code as their base.


## What's In This Project
To do the above, I needed to pull in a few packages from buildroot proper and
add a couple extra packages from GitHub.

From buildroot:
* IWD - Manages the WiFi connection
* SSHD - For obvious reasons
* BCM2835 - Needed for my OLED display

Other packages:
* SSD1306_OLED_RPI - The driver for the OLED controller (needs the BCM2835 driver)
* i2c_ipstat - A program / daemon I wrote to display the IP on the OLED.


## Building
To configure buildroot to use this repo, simply run the following in the root of
your buildroot tree:
```
make BR2_EXTERNAL=<path_to_this_project> rpiz2w_wifipidev_defconfig
```

After that, you should be good to go!


## Additional Notes
### Hardware
I have only tested this project on a Raspberry Pi Zero 2 W, though I don't see
why it wouldn't work for any other Pi variant. Additional defconfigs and
packages can/will be added for other boards as needed.

As for the OLED display, I have been using
[this 128x32 OLED](https://www.adafruit.com/product/3527) from AdaFruit.

### WiFi Info
To get the pi to automatically join your WiFi network, create a file in
`board/rootfs_overlay/var/lib/iwd/` named `<SSID>.psk`, where you replace
`<SSID>` with the SSID of the network to which you want to connect.

The contents of that `.psk` should look like this:
```
[Security]
PreSharedKey=<hashed-wifi-password>
```
I used `wpa_passphrase` to generate the hash.

Note: the `board/rootfs_overlay/var/lib/iwd` directory is in the `.gitignore`
file to avoid accidentally committing sensitive data.

### Credentials / Root Access
Because I am aiming to use this for development, I have set a root password of
`test`, and I have enabled root login over SSH.

THIS IS NOT SUITED FOR DEPLOYMENT!
