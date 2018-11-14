#!/bin/bash

set -e

BRANCH=${BRANCH:-master}
APP_DIR=${APP_DIR:-/tmp/app}
APP_START=${APP_START:-"npm start"}
REPOSITORY=${REPOSITORY:-"https://github.com/indexzero/http-server"}

if [[ ! -d $APP_DIR/.git ]]
then
    git clone --single-branch --branch $BRANCH $REPOSITORY $APP_DIR
    cd $APP_DIR
    npm install
else
    cd $APP_DIR
    # no error check - skip if we are offline
    set +e
    git fetch --all
    git reset --hard FETCH_HEAD
    npm install
    set -e
fi

echo "Starting $APP_START"
$APP_START &
PID=$!
echo PID: $PID

while true
do
    set +e
    git remote update >/dev/null
    UPDATE_CODE=$?
    set -e

    # check only if update succeeded (i.e. if we are not offline)
    if (( $UPDATE_CODE == 0 ))
    then
        git status --untracked-files=no | grep "Your branch is up-to-date" >/dev/null 
    else
        echo "NPG could not check for update - are we offline?"
    fi

    ps | grep "^ *$PID " >/dev/null 
    sleep 10
done

