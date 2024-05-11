#!/bin/bash

# Install the latest Java version
sudo apt update
sudo apt install default-jdk -y

# Check if Java is installed
if ! command -v java &> /dev/null
then
    echo "Java is not installed."
    exit 1
fi

# Get the Java version
java_version=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}')

echo "Java version $java_version is installed."

# Check if an older Java version is installed
if [[ "$java_version" < "11" ]]
then
    echo "An older Java version is installed."
    exit 1
fi

# Check if Java version 11 or higher is installed
if [[ "$java_version" > "11" ]] || [[ "$java_version" == "11" ]]
then
    echo "Java version 11 or higher is installed. Installation was successful."
    exit 0
fi

