#!/bin/bash

SENDGRID_API_KEY=$SEND_GRID_KEY
EMAIL_TO=$_EMAIL_TO
FROM_EMAIL=$_FROM_EMAIL
FROM_NAME=$_FROM_NAME
SUBJECT=$_SUBJECT

bodyHTML="<p>The build for $SHORT_SHA has been successfull.</p>"

maildata='{"personalizations": [{"to": [{"email": "'${EMAIL_TO}'"}]}],"from": {"email": "'${FROM_EMAIL}'",
	"name": "'${FROM_NAME}'"},"subject": "'${SUBJECT}'","content": [{"type": "text/html", "value": "'${bodyHTML}'"}]}'

curl --request POST \
  --url https://api.sendgrid.com/v3/mail/send \
  --header 'Authorization: Bearer '$SENDGRID_API_KEY \
  --header 'Content-Type: application/json' \
  --data "'$maildata'"
