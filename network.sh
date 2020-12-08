#!/bin/bash

if [ "$EUID" -ne 0 ] ;
	then echo "Run as Root"
	exit
fi

startFunctions() {

}

cont(){
	printf "\033[1;31mI have finished this task. Continue to next Task? (Y/N)\033[0m\n"
	read contyn
	if [ "$contyn" = "N" ] || [ "$contyn" = "n" ]; then
		printf "\033[1;31mAborted\033[0m\n"
		exit
	fi
	clear
}