# Dell R730xd Fan Control Issues
 Dell R730xd are great NAS servers for home or SMB use. Even though they're no longer supported, they can be low cost and pretty powerful + reliable. One key downside, however, is that they tend to not play well with third party (non-Dell) SSDs or PCIe cards. As a result, the fan controller automatically gets set to 40% minimum at all times.
 This is not acceptable for a home or small office environment, as it can be quite loud.

Most users by now have discovered the ipmitool hack to write raw hex to the firmware and disable third party PCIe fan response - but this didn't work for me. The fans stayed at 40% despite inlet temp being 23°C and CPU core temps being a maximum of 42°C. I had to go manual fan control unfortunately.

## The Fix

I wrote a simple zsh script to check your CPU core temp(s) and am running it as a system service. If CPU core temps exceed a specified temperature, it will use ipmitool raw commands to speed things up. My setup has dual CPUs, and is taking the higher of each's Core 0 to measure. The script checks when CPU temps are below the threshold, and will reduce fan speeds back to "normal" accordingly.

## ipmitool fan control

ipmitool raw 0x30 0x30 0x02 0xff 0x## where ## should be replaced with a hex value up to 100%

## WARNING

I offer NO WARRANTY and am NOT RESPONSIBLE for any sort of damage using manual fan control can cause! Please know what you're doing if you use this and monitor your system accordingly.
