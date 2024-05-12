#!/bin/bash

new_user=myapp
useradd $new_user -m

apt update && apt install nodejs npm wget -y

log_directory=$1

node_version=$(node -v)
echo "Node version $node_version is isntalled"

npm_version=$(npm -v)
echo "Npm version $npm_version is installed"

runuser -l $new_user -c "wget https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/bootcamp-node-envvars-project-1.0.0.tgz"

runuser -l $new_user -c "tar zxvf ./bootcamp-node-envvars-project-1.0.0.tgz"

export APP_ENV=dev DB_USER=myuser DB_PWD=mysecret

if [ ! -d "$log_directory" ]
then
  echo "Directory does not exists, creating it!"
  mkdir -p "$log_directory"
fi

export LOG_DIR="$log_directory"
chown $new_user -R $log_directory

runuser -l $new_user -c "
    export APP_ENV=dev &&
    export DB_PWD=mysecret &&
    export DB_USER=myuser &&
    export LOG_DIR=$log_directory &&
    cd package &&
    npm install &&
    node server.js &"

ps aux | grep node | grep -v grep
