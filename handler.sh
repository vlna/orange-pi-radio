#!/bin/bash

# Script to launch a web m3u or pls playlist (web radio) on mpd using mpc
# based on code from https://bbs.archlinux.org/viewtopic.php?id=119903

RADIO=`sed -n -e ${1}p /home/radio/radio.list`

# Extract file extension

EXT=`echo "${RADIO##*.}" | tr A-Z a-z`

case "$EXT" in
          "pls"   ).
          PL=`curl --post301 -L $RADIO | grep '^File[0-9]*' | sed -e 's/^File[0-9]*=//'`
          ;;

          "m3u" )
          PL=`curl --post301 -L $RADIO | sed -e '/^#/D' | sed "s/\r$//" | head -n1`
          ;;

          * )
          echo "Filename without a valid extension"
          exit 1;;
esac

# Store new channel for next/prev button

echo ${1} > /tmp/irchan.tmp

# Clear old playlist, add new playlist and play

mpc clear ; mpc add "$PL" ; mpc play
