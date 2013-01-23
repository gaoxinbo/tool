#!/bin/bash

if [ $# -lt 2 ];then
    echo "usage : classname namespace"
    exit 1
fi

ClassName=$1
shift
NameSpace=$@
ReverseNameSpace=""
for i in $NameSpace;do
    ReverseNameSpace="$i $ReverseNameSpace"
done

LowwerName=`tr '[A-Z]' '[a-z]' <<<"$ClassName"`
HeaderFile="$LowwerName.h"
CCFile="$LowwerName.cc"

function CheckExist(){
    if [ $# == 0 ];then
        return
    fi
    filename=$1

    if [ -e $filename ];then
        echo "$filename has already existed. Create a new one or not?(y/n)" 
        read action
        case $action in 
            N|n)
                exit 0
            ;;
        esac 
    fi

    rm $filename -f
}

function GenerateHeader(){
    touch $HeaderFile
    UpperName=`tr '[a-z]' '[A-Z]' <<<"$ClassName"`
    Date=`date +"%Y-%m-%d"`
    Guard="_${UpperName}_H_"
    
    echo """// File: $HeaderFile
// Author: Gao Xinbo gaoxinbo1984@gmail.com
// Version: 1.0
// Date: $Date
// Copyright `date +"%Y"`, Gao Xinbo.  All rights reserved.

#ifndef ${Guard}
#define ${Guard}
`for i in $NameSpace;do
    echo namespace $i {
done`

class ${ClassName} {
  public:
    ${ClassName}();
    ~${ClassName}();

  private:
    ${ClassName}(const ${ClassName}&);
    void operator=(const ${ClassName}&);
};

`for i in ${ReverseNameSpace};do
    echo "}  // namespace $i"
done`
#endif  // ${Guard}
""" >> $HeaderFile
}

function GenerateCCFile(){
    touch $CCFile
    echo """// Copyright `date +"%Y"`, Gao Xinbo.  All rights reserved.
// Author: Gao Xinbo gaoxinbo1984@gmail.com

#include \"${LowwerName}.h\"
`for i in $NameSpace;do
    echo namespace $i {
done`

`for i in ${ReverseNameSpace};do
    echo "}  // namespace $i"
done`
""" >> $CCFile
}

CheckExist $HeaderFile
CheckExist $CCFile

GenerateHeader
GenerateCCFile
