#!/bin/bash

user=$USER
echo "Do you want to sort output by memory or CPU (m/c)"
read sort
echo "How many lines do you want to display?"
read linesNumber

if [ "$sort" = "m" ]
then
  ps u -U "$user" --sort -rss | head -n $(("$linesNumber" + 1))
elif [ "$sort" = "c" ]
then
        ps u -U "$user" --sort -%cpu | head -n $(("$linesNumber" + 1))
else
  echo "Please choose sorting method. Exiting!"
fi
