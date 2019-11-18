#!/bin/bash -x 

echo "*****WELCOME TO SNAKE AND LADDER STIMULATOR*****"

#VARIABLES
declare positionOfPlayer=0
declare IFNOPLAY=0
declare IFLADDER=1
declare IFSNAKE=2
declare moveValue=0
declare moveOption=0
declare noOfTimesDiceRolled=0
declare WINNING_POSITION=100
declare ZERO_POSITION=0
declare NO_OF_PLAYERS=2
declare PLAYER1=1
declare PLAYER2=2
declare playerTurn=2


#DICTIONARY DECLARATION
declare -A diceChart
declare -A playerChart

function playingOption()
{
	optionToPlay=$[ ($RANDOM%3) ]
	echo $optionToPlay
}

function rollingDice()
{
	diceRoll=$[ ($RANDOM%6) +1 ]
	echo $diceRoll
}
function assigningPlayerPosition()
{
	for(( player=1; i<=$NO_OF_PLAYERS; i++ ))
	do
		playerChart[$player]=$ZERO_POSITION
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
while [ $positionOfPlayer -le $WINNING_POSITION ]
do
	moveOption=$(playingOption)
	moveValue=$(rollingDice)
	playerTurn=$(whichPlayerWillPlay)
	if [[  $moveOption -eq $IFNOPLAY ]]
	then
		echo "NO MOVE"
		echo "POSITION:" $positionOfPlayer
	elif [[ $moveOption -eq $IFLADDER ]]
	then
		echo "YOU WILL MOVE BY POSITION" $moveValue
		positionOfPlayer=$(( $moveValue + $positionOfPlayer ))
		echo "POSITION:"$positionOfPlayer
	elif [[ $moveOption -eq $IFSNAKE ]]
	then
		echo "YOU WILL COME BEHIND BY POSITION" $moveValue
		positionOfPlayer=$(( $positionOfPlayer - $moveValue ))
		echo "POSITION:" $positionOfPlayer
	fi

	if [ $positionOfPlayer -lt $ZERO_POSITION ]
	then
		positionOfPlayer=$ZERO_POSITION
	elif [ $positionOfPlayer -eq $WINNING_POSITION ]
	then
		playerChart[$playerTurn]=$positionOfPlayer
		break
	elif [ $positionOfPlayer -gt $WINNING_POSITION ]
	then
		positionOfPlayer=$(( $positionOfPlayer -$moveValue ))
	fi

	playerChart[$playerTurn]=$positionOfPlayer

done
for column in  ${!playerChart[@]}
do
	echo ' Player-' $column 'won by being at position' ${playerChart["$column"]}
done |
sort -n -k8 | tail -1

