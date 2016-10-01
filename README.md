# orange-pi-radio
Orange Pi PC and Armbian based radio

## Hardware list
- Orange Pi PC
- Power adapter 5V, 2A, 4.0x1.7mm (BS-522CO/6388)
- USB Wifi (ZB02500 0bda:8179 Realtek Semiconductor Corp.)
- IR Remote (Arduino remote with 17 buttons)
- Cable (Nokia CA-75U)
- Radio/Amplifier with external input or Speakers

## Instalation

Install Armbian.

Install `apt-get install firmware-realtek` to get USB wifi working (internet needed, use ethernet port)

Create/modify `/etc/network/interfaces` to connect wirelessly.

Create/modify `/etc/asound.conf` to make jack 3.5mm jack default.

Create/modify `/etc/lirc/lircd.conf` to decode specific remote.

Create account to receive IR commands and to forward it.

`adduser --uid 2222 --disabled-password --disabled-login radio`

Create files `handler.sh` and `.lircrc` in `/home/radio`

Set proper ownership

`chown -R radio:radio /home/radio`

Add following line before line `exit 0` in `/etc/rc.local` to run receive IR after reboot.

`sudo -H -u radio /usr/bin/irexec -d`
