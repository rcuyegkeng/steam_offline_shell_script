#!/bin/sh

if [ "$1" = "--help" ]; then
  echo "To start steam in online mode : $0"
  echo "To start steam in offline mode : $0 --offline"
  exit 0
fi

VDFDIR=$HOME/.steam/steam/config
VDFFILE=loginusers.vdf
VDFFILEPATH=$VDFDIR/$VDFFILE

if [ ! -f $VDFFILEPATH ]; then
  echo "Can not find $VDFDIR/$VDFFILE"
  exit 1;
fi

# make a backup copy of the vdf file if a backup does not exist.
if [ ! -f $VDFFILEPATH.backup ]; then
  cp $VDFFILEPATH $VDFFILEPATH.backup
fi

if [ "$1" = "--offline" ]; then
  sed -e 's/\"WantsOfflineMode\"\s*\"0\"/\"WantsOfflineMode\"\t\t\"1\"/'  -e 's/\"SkipOfflineModeWarning\"\s*\"0\"/\"SkipOfflineModeWarning\"\t\t\"1\"/' -i $VDFFILEPATH
else
  sed -e 's/\"WantsOfflineMode\"\s*\"1\"/\"WantsOfflineMode\"\t\t\"0\"/'  -e 's/\"SkipOfflineModeWarning\"\s*\"1\"/\"SkipOfflineModeWarning\"\t\t\"0\"/' -i $VDFFILEPATH
fi

/usr/bin/steam 
