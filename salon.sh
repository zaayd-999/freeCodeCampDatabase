#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=salon -t --no-align -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"

main() {
  while true; do
    echo "Welcome to My Salon, how can I help you?"
    
    # Display services
    SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id")
    echo "$SERVICES" | while IFS='|' read SERVICE_ID NAME
    do
      echo "$SERVICE_ID) $NAME"
    done

    read SERVICE_ID_SELECTED

    # Validate service
    SELECTED_SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED;")
    if [[ -z $SELECTED_SERVICE_NAME ]]
    then
      echo -e "\nI could not find that service. What would you like today?\n"
      continue
    fi

    # Get phone number
    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE
    
    # Check if customer exists
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE';")

    if [[ -z $CUSTOMER_NAME ]]
    then
      echo -e "\nI don't have a record for that phone number, what's your name?"
      read CUSTOMER_NAME
      $PSQL "INSERT INTO customers(phone,name) VALUES('$CUSTOMER_PHONE','$CUSTOMER_NAME');" > /dev/null
    fi

    # Get customer ID
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE';")

    # Get appointment time
    echo -e "\nWhat time would you like your $SELECTED_SERVICE_NAME, $CUSTOMER_NAME?"
    read SERVICE_TIME

    # Create appointment
    $PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES ($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME');" > /dev/null
    
    # Confirm appointment
    echo -e "\nI have put you down for a $SELECTED_SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
    
    break
  done
}

main