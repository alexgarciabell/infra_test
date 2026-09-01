#!/bin/bash

FILE="$1"
SATID="$2"
SECRET="$3"
VERSION="$4"
ENVNAME="$5"

#
# Get a SAT
#
response=$(curl -s -q -X POST https://sat-prod.codebig2.net/oauth/token -H "X-Client-Id: "$SATID"" -H "X-Client-Secret: "$SECRET" ")
echo $response
token=$(echo $response | jq -r '.access_token')
echo $token


cat "$FILE" | awk  '{ print "\x22"$1"\x22"":""\x22"$2"\x22""," }' > hosts_formatted; cat hosts_formatted | tr '\n' ' ' > foo; payload=`cat foo | sed 's/, /,/g' | awk ' { print "\x27\x7B" $1 "\x7D\x27" }' | sed 's/,}/}/g'`;
echo $token
echo ====================
echo $payload
echo ====================
request="curl --header \"Accept: application/json\" --header \"Content-Type: application/json\" --header \"Authorization: Bearer $token\" -X PUT -d $payload https://ci.applicationdiscoveryadminservice.ccp.xcal.tv:9443/appdiscoveryAdminService/data/TSPConfig/appdiscoveryAdminService/"$VERSION"/"$ENVNAME"";
echo $request
eval $request
rm -f foo hosts_formatted