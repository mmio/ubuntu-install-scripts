#!/bin/bash
n="`pactl list short sinks | cut -f1`"

for i in $n;
do `pactl set-sink-mute $i toggle`;
done;
