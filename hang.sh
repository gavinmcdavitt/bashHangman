#!/bin/bash

# Initialize a counter variable
counter=8
words=("apple" "bread" "climb" "drive" "earth" "flame" "grape" "hover" "input" "jelly" 
       "kneel" "lemon" "music" "night" "ocean" "pearl" "queen" "racer" "stone" "tower" 
       "ultra" "vivid" "whale" "xenon" "youth")

random=$(($RANDOM % ${#words[@]}))
selected_word=${words[$random]}
#echo "Selected word is: $selected_word"
echo "This is hangman. Please take a guess at what the 5-letter word could be."

# Initialize associative array
declare -A my_map

# Initialize player string with underscores
player=$(printf "%${#selected_word}s" | tr ' ' '_')

# Start the while loop
while [ $counter -ge 0 ]; do
  echo "Please enter a letter:"
  read -r charInput

  # Flag to check if the letter was guessed correctly
  correct_guess=false

  # Check if the guessed letter is in the selected word
  for (( i=0; i<${#selected_word}; i++ )); do
    char="${selected_word:$i:1}"
    if [ "$char" == "$charInput" ]; then
      my_map["$i"]="$char"
      correct_guess=true
    fi
  done

  if $correct_guess; then
    echo "Correct guess!"
  else
    echo "Incorrect guess."
    ((counter--))
  fi

  # Display the current state of the guessed word
  player=""
  for (( i=0; i<${#selected_word}; i++ )); do
    if [[ -v my_map[$i] ]]; then
      player+="${my_map[$i]}"
    else
      player+="_"
    fi
  done

  echo "Current word: $player"
  echo "Attempts remaining: $counter"

  # Check if the player has guessed all letters
  if [[ "$player" == "$selected_word" ]]; then
    echo "Congratulations! You've guessed the word."
    break
  fi
done

if [[ "$player" != "$selected_word" ]]; then
  echo "Game over! The word was: $selected_word"
fi

echo "All done!"

echo "Press any key to exit..."
read

