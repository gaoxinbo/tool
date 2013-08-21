#!/bin/bash

prog=`ls *.go`

path=`which go`
if [ "$path" == "" ];then
  echo "have not installed go lang yet"
  exit 1
fi

bin=
failure=

for item in $prog
do
  go build $item   
  name=`echo $item | awk -F'.' '{print $1}'`
  bin="$bin $name"
done


mkdir -p ~/.toolbox/bin
for item in $bin
do
  mv $item ~/.toolbox/bin
done

