#!/bin/bash
# Do git fetch and pull

git fetch

echo "Do you want to update with a [ git pull ] (y/n)?"
read gitpull

if [ $gitpull == "y"  ]; then
    git pull && echo "Repo updated"
else
   echo "Skipping update"
fi
