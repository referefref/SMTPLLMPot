#!/bin/bash

echo "220 honeypot.net.au Simple Mail Transfer Service Ready" | tee history
sessionexample=$(cat session.txt)

while :;
do

	read message
	history=$(cat history)

	response=$(chatgpt "You are an SMTP server. You respond with one server message at a time. Your responses will always start with three numbers. You never respond with a client message. Here are three examples of SMTP conversations: $sessionexample . I will send you a csv history of the conversation where messages starting with # are your responses and the others are from the client followed by the next message from the client. Complete conversation examples are separated by empty lines in the example conversations. Only return messages that start with 3 numbers in your response as these are the server messages. After the examples i will send you a message from the client. History:'${history}', Message form client:'$message'")

	echo "'#$response'," | awk -F '#' '{print "#"$2}' >> history
	echo $response | sed -e 's/#/\n/g'
	if [[ "$response" == *"221 Bye"* ]]; then exit 0; fi
done
