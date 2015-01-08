#!/bin/sh

rm_ln ()
{
  DEST="$HOME/.$(basename $1)"
  LN_TARG=`readlink "$DEST"`

  if [[ "$LN_TARG" == "$1" ]]
  then
    echo "Removing link $DEST"
    rm $DEST
  fi
}

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

for f in $DIR/files/*
do
  rm_ln $f
done
