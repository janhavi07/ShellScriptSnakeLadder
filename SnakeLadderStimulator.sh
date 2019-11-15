#!/bin/bash -x 

echo "WELCOME TO SNAKE AND LADDER STIMULATOR"

#VARIABLES
position=0
NOPLAY=0
LADDER=1
SNAKE=2
moveValue=0
moveOption=0


function playOption()
{
	option=$[ ($RANDOM%3) ]
	echo $option
}

function rollDice()
{
	diceRoll=$[ ($RANDOM%6) +1 ]
	echo $diceRoll
}

echo "ROLL THE DICE"
while [ $position -le 100 ]
do
	moveOption=$(playOption)
	moveValue=$(rollDice)

	if [[  $moveOption -eq $NOPLAY ]]
	then
		echo "NO MOVE"
		echo "POSITION:" $position
	elif [[ $moveOption -eq $LADDER ]]
	then
		echo "YOU WILL MOVE BY POSITION" $moveValue
		position=$(( $moveValue + $position ))
		echo "POSITION:"$position
	elif [[ $moveOption -eq $SNAKE ]]
	then
		echo "YOU WILL COME BEHIND BY POSITION" $moveValue
		position=$(( $position - $moveValue ))
		echo "POSITION:" $position
	fi
	if [ $position -lt 0 ]
	then
		position=0
	fi
done
echo "YOU WIN"
echo "FINAL POSITION IS: " $position
