#!/bin/sh

mk_ln ()
{
  DEST="$HOME/.$(basename $1)"
  echo "Creating link $DEST -> $1"
  ln -s $1 $DEST
}

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

for f in $DIR/files/*
do
  mk_ln $f
done
