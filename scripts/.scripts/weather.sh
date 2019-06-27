#!/bin/sh

string=`curl -s "http://wttr.in/Samara?m&format=%c+%t"`

if [ $? != 0 ] || [[ $string == *"Internal Server Error"*  ]]; then 
  echo "unknown"
else
  echo "$string"
fi
