#!/bin/sh
# Create a notebook directory for today. Add a symlink in $HOME to make it
# easier to access.

cd $HOME
today=`date "+%Y/%m%d"`
mkdir -p $HOME/notebook/$today
rm $HOME/today
ln -s $HOME/notebook/$today today
