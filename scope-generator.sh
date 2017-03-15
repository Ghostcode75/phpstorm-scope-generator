#!/bin/bash
URL=$1 # A complete pull request URL, e.g. https://github.com/savaslabs/sumac/pull/15
PARSED_URL=`echo $URL | sed 's=/pull/=/pulls/=g' | sed 's=https://github.com/==g'`
SCOPE_NAME=`echo $PARSED_URL | sed 's=/=-=g'`
PULL_REQUEST_FILES=`curl -s -q -H "Authorization: token $PHPSTORM_SCOPE_GENERATOR_TOKEN" https://api.github.com/repos/$PARSED_URL | jq '.[].filename'`
SCOPE_FILE="$SCOPE_NAME.xml"
if [ -f $SCOPE_FILE ]; then rm $SCOPE_FILE; fi
touch $SCOPE_FILE
echo "<component name=\"DependencyValidationManager\"><scope name=\"$SCOPE_NAME\" pattern=\"" > $SCOPE_FILE
FILE_CONTENTS=''
while read -r FILE; do
    echo "file:$FILE||" | sed 's="==g' | sed 's/^ *//g' >> $SCOPE_FILE
done <<< "$PULL_REQUEST_FILES"
echo '"/></component>' >> $SCOPE_FILE
echo $(while read line; do printf "%s" "$line"; done < $SCOPE_FILE) > $SCOPE_FILE
sed -i.bak 's=||"/>="/>=g' $SCOPE_FILE
rm $SCOPE_FILE.bak
mkdir -p $(pwd)/.idea/scopes
mv $SCOPE_FILE $(pwd)/.idea/scopes/
echo "Generated scope file $SCOPE_NAME"
