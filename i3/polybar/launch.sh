#!/usr/bin/env bash

killall -q polybar
sleep 0.5

polybar main &
