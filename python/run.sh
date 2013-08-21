#!/bin/bash

file=`ls *.py`


mkdir -p ~/.toolbox/bin

for item in $file
do
  cp $item ~/.toolbox/bin
done
