#!/bin/bash

res=$(curl --no-progress-meter localhost:17001 2>&1)
# debugging
# echo $res

if [[ $res == "curl: (1) Received HTTP/0.9 when not allowed" ]]
then
  echo "Can connect to ecodms port"
  exit 0
else
  echo "could not connect to ecodms port"
  echo $res
  exit 1
fi