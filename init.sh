rm ./aliens/*

name=$(date +%A-%B-%d-%Y-%H:%M:%S:%N|md5sum|cut -d' ' -f1)
mkdir /home/bblankenship/alien-survival-simulator/aliens
touch /home/bblankenship/alien-survival-simulator/aliens/$name
mkdir /home/bblankenship/alien-survival-simulator/humans-p
mkdir /home/bblankenship/alien-survival-simulator/humans/population
echo 8000000000 /home/bblankenship/alien-survival-simulator/humans/population
echo .05 /home/bblankenship/alien-survival-simulator/humans/repro-rate
echo -e "name=$name
echo -e ALIVE
age=1
parent=Crash Survivor" > /home/bblankenship/alien-survival-simulator/aliens/$name

echo $name > livingaliens

echo "day=1" >./day
