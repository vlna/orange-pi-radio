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

Install `apt-get install firmware-realtek` to get USB wifi working (internet needed, use ethernet port, driver already included in Armbian 5.20 and newer) 

Create/modify `/etc/network/interfaces` to connect wirelessly.

Install `apt-get install mpd mpc` to play and controll music.

Create/modify `/etc/asound.conf` to make jack 3.5mm jack default.

Create/modify `/etc/lirc/lircd.conf` to decode specific remote.

Create account to receive IR commands and to forward it.

`adduser --uid 2222 --disabled-password --disabled-login radio`

Create files `handler.sh` and `.lircrc` and `radio.list` in `/home/radio`

Set proper ownership

`chown -R radio:radio /home/radio`

Use `crontab -e` and append following line to receive IR after reboot (you can experiment with time).

`@reboot sleep 60 ; sudo -H -u radio /usr/bin/irexec -d`

## Troubleshooting

Q: MP3 radios are too quiet  
A: Append following lines to `/etc/mpd.conf`

    decoder {
        plugin "mad"
        enabled "no"
    }

## Remote control keys

* UP/DOWN changes volume
* LEFT/RIGHT prev/next radio
* ASTERISK random radio
* 1234567890 radio selection
* HASH confirms typed numbers
* OK mute/unmute

note: any non-numeric key resets typed numbers, sequence `1 2 UP 3 1 HASH` will tune station on line 31 in file `radio.list`


