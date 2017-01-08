#!/bin/sh

# start taffybar
if [ -z "$(pgrep -f taffybar-linux)" ] ; then
  echo "----------------" >> ~/.config/taffybar/debug.log &
  echo "$(date)" >> ~/.config/taffybar/debug.log &
  taffybar &>> ~/.config/taffybar/debug.log &
fi
