#!/bin/bash -x 

echo "*****WELCOME TO SNAKE AND LADDER STIMULATOR*****"

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
NO_OF_PLAYERS=2
PLAYER1=1
PLAYER2=2
playerTurn=2

#DICTIONARY DECLARATION
declare -A diceChart
declare -A playerChart

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
function assigningPlayerPosition()
{
	for(( i=1; i<=$NO_OF_PLAYERS; i++ ))
	do
		playerChart[$i]=$ZERO_POSITION
	done
}
function whichPlayerWillPlay()
{
	if [[ $playerTurn -eq $PLAYER1 ]]
        then
                playerTurn=$PLAYER2
        else
                playerTurn=$PLAYER1
        fi
	echo $playerTurn

}
echo "*****ROLL THE DICE****"
assigningPlayerPosition
while [ $position -le $WINNING_POSITION ]
do
	moveOption=$(playOption)
	moveValue=$(rollDice)
	playerTurn=$(whichPlayerWillPlay)
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
			position=$ZERO_POSITION
			elif [ $position -eq $WINNING_POSITION ]
		then
			playerChart[$playerTurn]=$position
			break
		elif [ $position -gt $WINNING_POSITION ]
		then
			position=$(( $position -$moveValue ))
		fi

	playerChart[$playerTurn]=$position

done
for k in  ${!playerChart[@]}
do
	echo ' Player-' $k 'won by being at position' ${playerChart["$k"]}
done |
sort -n -k8 | tail -1

