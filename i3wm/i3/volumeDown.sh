#!/bin/bash
n="`pactl list short sinks | cut -f1`"

for i in $n;
do `pactl set-sink-volume $i -5%`;
done;
