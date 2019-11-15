#!/bin/bash -x 

echo "WELCOME TO SNAKE AND LADDER STIMULATOR"

#VARIABLES
position=0
IFNOPLAY=0
IFLADDER=1
IFSNAKE=2
moveValue=0
moveOption=0
noOfTimesDiceRolled=0
WINNING_POSITION=100
ZERO_POSITION=0

#DICTIONARY DECLARATION
declare -A diceChart

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
	noOfTimesDiceRolled=$(( $noOfTimesDiceRolled +1 ))

	if [[  $moveOption -eq $IFNOPLAY ]]
	then
		echo "NO MOVE"
		echo "POSITION:" $position
	elif [[ $moveOption -eq $IFLADDER ]]
	then
		echo "YOU WILL MOVE BY POSITION" $moveValue
		position=$(( $moveValue + $position ))
		echo "POSITION:"$position
	elif [[ $moveOption -eq $IFSNAKE ]]
	then
		echo "YOU WILL COME BEHIND BY POSITION" $moveValue
		position=$(( $position - $moveValue ))
		echo "POSITION:" $position
	fi
	if [ $position -lt $ZERO_POSITION ]
	then
		position=0
	elif [ $position -eq $WINNING_POSITION ]
	then
		diceChart[$noOfTimesDiceRolled]=$position
		break
	elif [ $position -gt $WINNING_POSITION ]
	then
		position=$(( $position -$moveValue ))
	fi
	diceChart[$noOfTimesDiceRolled]=$position
done
echo "YOU WIN"
for k in  ${!diceChart[@]}
do
	echo ' DICEROLLED: ' $k 'times. Final POSITION:' ${diceChart["$k"]}
done |
sort -n -k2 | tail -1

