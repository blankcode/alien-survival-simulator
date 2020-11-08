#!/bin/bash

# reset aliens
rm ./aliens/* 

# Name of the alien that crash lands.
name=$(date +%A-%B-%d-%Y-%H:%M:%S:%N|md5sum|cut -d' ' -f1)
mkdir /home/bblankenship/alien-survival-simulator/aliens
touch /home/bblankenship/alien-survival-simulator/aliens/$name
mkdir /home/bblankenship/alien-survival-simulator/humans-p
mkdir /home/bblankenship/alien-survival-simulator/humans/population
echo 8000000000 /home/bblankenship/alien-survival-simulator/humans/population

# Reproduction Rate of the humans per day
  # 0.0070410958904109589041095890411 (2.57%/Yr) https://en.wikipedia.org/wiki/Total_fertility_rate Net Rate
echo .007 /home/bblankenship/alien-survival-simulator/humans/repro-rate
echo -e "name=$name
echo -e ALIVE
age=1
parent=Crash Survivor" > /home/bblankenship/alien-survival-simulator/aliens/$name

echo $name > livingaliens

echo "day=1" >./day
