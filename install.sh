#!/bin/bash

SCRIPT=$(realpath -e "$0")
BASEDIR=$(dirname "$SCRIPT")

# Obtain current project name
CUR_PROJECT_NAME=$(echo "$BASEDIR" | sed "s|$(dirname "$BASEDIR")/||")

### Change project name ###

read -p 'enter project name: ' PROJECT_NAME

# Rename inner folder
mv "$BASEDIR/$CUR_PROJECT_NAME" "$BASEDIR/$PROJECT_NAME"

# Rename root folder
BASEDIR=$(dirname "$BASEDIR")
mv "$BASEDIR/$CUR_PROJECT_NAME" "$BASEDIR/$PROJECT_NAME"

SCRIPT=$(realpath -e "$0")
BASEDIR=$(dirname "$SCRIPT")

        ######


### Replace files ###

# Replace assets to project root
ASSETSDIR="$BASEDIR/assets"
cp -R "$ASSETSDIR/." "$BASEDIR"
rm -r "$ASSETSDIR"

        ######


### Remove git files ###

rm "$BASEDIR/LICENSE" "$BASEDIR/readme.md"
rm -rf "$BASEDIR/.git"

        ######


### Change interpreter path ###

PATH_TO_INTERPRETER="$BASEDIR/.venv/bin/python"

read -p "path to interpreter: " -i $PATH_TO_INTERPRETER -e PATH_TO_INTERPRETER

PATH_TO_LANG_CLIENT_SETTINGS="$BASEDIR/.vim/language-client.json"
SEDARG="s|\"InterpreterPath\".\+,|\"InterpreterPath\": \""$PATH_TO_INTERPRETER"\",|"

sed -i "$SEDARG" "$PATH_TO_LANG_CLIENT_SETTINGS"

        #######


# Remove itself
rm "$SCRIPT"
