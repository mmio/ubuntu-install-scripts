#!/bin/bash

pressed_btn=$1

function volumeUp() {
    sink_id=$1
    volume=$2
    pactl set-sink-volume $sink_id +$volume%
}

function volumeController() {
    if [ "$pressed_btn" == "up" ]
    then
	echo "Pressed the VOLUME-UP button"
    elif [ "$pressed_btn" == "down" ]
    then
	echo "Pressed the VOLUME-DOWN button"
    elif [ "$pressed_btn" == "mute" ]
    then
	echo "Pressed the VOLUME-MUTE button"
    fi
}

n="`pactl list short sinks | cut -f1`"

if [ -z "$n" ]
then
    n=0
fi

for i in $n;
do volumeUp $i 5
done;

volumeController
