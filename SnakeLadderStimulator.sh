#!/bin/bash -x

echo "WELCOME TO SNAKE AND LADDER STIMULATOR"

#VARIABLES
position=0

diceRoll=$[ ($RANDOM%6) +1 ]
echo $diceRoll
