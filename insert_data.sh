#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"

# Clear existing data
echo $($PSQL "TRUNCATE TABLE games, teams;")

tail -n +2 games.csv | cut -d',' -f3,4 | tr ',' '\n' | sort | uniq | while IFS= read -r country
do
  $PSQL "INSERT INTO teams(name) VALUES('$country');"
done

cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != "year" ]] 
  then
    # Get or insert winner team
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
    if [[ -z "$WINNER_ID" ]]
    then
      # Insert and then get the ID separately
      $PSQL "INSERT INTO teams(name) VALUES ('$WINNER');" > /dev/null
      WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
    fi

    # Get or insert opponent team
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")
    if [[ -z "$OPPONENT_ID" ]]
    then
      # Insert and then get the ID separately
      $PSQL "INSERT INTO teams(name) VALUES ('$OPPONENT');" > /dev/null
      OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")
    fi

    # Insert Game data
    $PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS);"
  fi
done