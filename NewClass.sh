#!/bin/bash

if [ $# != 2 ];then
    echo "usage : classname namespace"
    exit 1
fi

ClassName=$1
NameSpace=$2

HeaderFile="$1.h"
CCFile="$1.cc"

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
    
    echo """// @file $HeaderFile
// @author gaoxinbo gaoxinbo1984@gmail.com
// @version 1.0
// @date $Date    

#ifndef ${UpperName}_H    
#define ${UpperName}_H    

namespace ${NameSpace}{

class ${ClassName}{
  public:
    ${ClassName}();
    ~${ClassName}();

  private:
    ${ClassName}(const ${ClassName}&);
    void operator=(const ${ClassName}&);
};

} //namespace
#endif
""" >> $HeaderFile
}

function GenerateCCFile(){
    touch $CCFile
    echo """#include \"${ClassName}.h\"

namespace ${NameSpace}{

} //namespace
""" >> $CCFile
}

CheckExist $HeaderFile
CheckExist $CCFile

GenerateHeader
GenerateCCFile
