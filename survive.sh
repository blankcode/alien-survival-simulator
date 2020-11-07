﻿# Alien Survival simulator
# we start with one alien survivor having crash landed on earth.
# this species is asexual
# each day one of four things might happen:
# the alien could die
# the alien could do nothing but survive
# the alien could reproduce doubling itself
# the alien could reproduce tripling itself
# Each alien will be represented by a file on the disk
#       an alien will consist of the following
#       File name (md5sum based on the time/date code from "date")
#       age: (int in days)
#               number of children (offspring): (int)
#               parent: md5sum filename of the incident that spawned this one
#               Possibly more data, yet to be decided

# Functions (Events)1
# die: Delete the alien's file
# nothing: Do Nothing
# double: reproduce
# triple: reproduce two times

# Functions (Support for event)
# reproduce: Create a new alien file
# age: increase the age of the alien

# functions

cd /home/bblankenship/alien-survival-simulator

age() {
	age=$(($myage+1))
        sed -i -e "s/^age=.*$/age=$age/" $alien
}

die() {
        #echo -e "DEAD" >> $alien
        sed -i -e "s/ALIVE/DEAD/" $alien
	echo -e "Day $day died" >> $alien
	echo -e "Day $day $childname Died" >> ./aliens/$myparrent
}

double() {
        reproduce
}

triple() {
        reproduce;reproduce
}

reproduce() {
        childname=$(date +%A-%B-%d-%Y-%H:%M:%S:%N|md5sum|cut -d' ' -f1)
        echo -e "name=$childname" > ./aliens/$childname
        echo -e "parent=$me" >> ./aliens/$childname
        echo -e "ALIVE" >> ./aliens/$childname
        echo -e "age=1" >> ./aliens/$childname
	echo -e "Day $day Born" >> ./aliens/$childname
	echo -e "Day $day gave birth to $childname" >> ./aliens/$me
}

outcome() {
        event=$((RANDOM%4+1))
        if [[ $event == 1 ]]; then
                die; echo "$me died"
        elif [[ $event == 2 ]]; then
                echo "$me did nothing today"
        elif [[ $event == 3 ]]; then
                double; echo "$me reproduced"
        elif [[ $event == 4 ]]; then
                triple; echo "$me reproduced twice"
        fi
}

newday() {
	day=$(grep day ./day)
	day=$(($day+1))
}

init() {
	rm ./aliens/*

	name=$(date +%A-%B-%d-%Y-%H:%M:%S:%N|md5sum|cut -d' ' -f1)
	mkdir /home/bblankenship/alien-survival-simulator/aliens
	touch /home/bblankenship/alien-survival-simulator/aliens/$name
	echo -e "name=$name
	echo -e ALIVE
	age=1
	parent=Crash Survivor" > /home/bblankenship/alien-survival-simulator/aliens/$name

	echo $name > livingaliens

	echo "day=1" >./day
	
	#newfirst

}

newfirst() {
        run=$(($run+1))
	echo "$run," >> ./thisrun.csv
}

main() {

        thisrun=$(tail -n1 ./thisrun.csv)
        run=$(echo $thisrun | cut -d"," -f1)

        grep -l "ALIVE" ./aliens/* > ./livingaliens
	newday
        for alien in $(cat livingaliens)
                do
                        me=$(grep name $alien | cut -d= -f2)
                        myparrent=$(grep parrent $alien | cut -d= -f2)
                        myage=$(grep age $alien | cut -d= -f2)
                        age
                        outcome
			
                done
	population=$(wc -l ./livingaliens | awk {'print $1'})
	sed -i 's/$thisrun/$thisrun,$population/g'

	if [[ $population > 5000 ]] 
		then
			init
	fi

}

main;
