#!/bin/sh
# Go through the notebook directory and remove empty directories.

dirs=`find $HOME/notebook -mindepth 1 -maxdepth 2 -type d -name "[0-9]*"`
for d in $dirs
do
    rmdir $d >/dev/null 2>&1
done

