#!/bin/bash

set -e

IN_TO=$1
IN_SUBJECT=$2
IN_BODY=$3

json_escape() {
    printf '%s' $1 | python -c 'import json,sys; print(json.dumps(sys.stdin.read()))'
}

CURL_TO=$(json_escape "${IN_TO}")
CURL_SUBJECT=$(json_escape "${IN_SUBJECT}")
CURL_BODY=$(json_escape "${IN_BODY}")

if [[ "${IN_SUBJECT}" =~ ^(PROBLEM:|Problem:).*$ ]] ; then
    echo "We received a PROBLEM!"
    HTTP_RESPONSE=`curl --write-out %{http_code} --silent --output /dev/null -X POST --data '{ "embeds": [{"title": '"${CURL_SUBJECT}"', "url": "https://zabbix.your-domain-bleh.foo/", "description": '"${CURL_BODY}"', "type": "link", "thumbnail": {"url": "http://icons.iconarchive.com/icons/paomedia/small-n-flat/96/sign-warning-icon.png"}}] }' -H "Content-Type: application/json" https://discordapp.com/api/webhooks/xxx/yyy`
elif [[ "${IN_SUBJECT}" =~ ^(OK:|Resolved:).*$ ]] ; then
    echo "We received OKAY!"
    HTTP_RESPONSE=`curl --write-out %{http_code} --silent --output /dev/null -X POST --data '{ "embeds": [{"title": '"${CURL_SUBJECT}"', "url": "https://zabbix.your-domain-bleh.foo/", "description": '"${CURL_BODY}"', "type": "link", "thumbnail": {"url": "http://icons.iconarchive.com/icons/paomedia/small-n-flat/256/sign-check-icon.png"}}] }' -H "Content-Type: application/json" https://discordapp.com/api/webhooks/xxx/yyy`
else
    echo "Dunno what this was: ${IN_SUBJECT}"
    HTTP_RESPONSE=`curl --write-out %{http_code} --silent --output /dev/null -X POST --data '{ "embeds": [{"title": '"${CURL_SUBJECT}"', "url": "https://zabbix.your-domain-bleh.foo/", "description": '"${CURL_BODY}"', "type": "link", "thumbnail": {"url": "http://icons.iconarchive.com/icons/paomedia/small-n-flat/256/sign-question-icon.png"}}] }' -H "Content-Type: application/json" https://discordapp.com/api/webhooks/xxx/yyy`
fi

if [[ "${HTTP_RESPONSE}" != "204" ]] ; then
    echo "Received HTTP-Code: ${HTTP_RESPONSE}"
    exit 1
else
    exit 0
fi