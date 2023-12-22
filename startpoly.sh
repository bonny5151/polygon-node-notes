#!/bin/bash


echo "starting heimdalld service"
service heimdalld start
if [[ $? -eq 0 ]]; then
    echo "started heimdalld service"
else
  echo "failed to start heimdalld"
  exit 1
fi

while true
do
  catchingup=$(curl localhost:26657/status 2>/dev/null | grep catching_up | sed -E "s/.*: (.*)/\1/") ; 
  if [[ "$catchingup" == "false" ]]; then 
     echo "catchingup false starting bor service"
     service bor start 
     echo "started bor service"
     break
  else
    echo "catching up: $catchingup"
    sleep 5 
  fi
done

echo "exit done"
