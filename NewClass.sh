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

    echo "// @file $HeaderFile" >> $HeaderFile
    echo "// @author gaoxinbo gaoxinbo1984@gmail.com" >> $HeaderFile
    echo "// @version 1.0 " >> $HeaderFile
    echo "// @date $Date " >> $HeaderFile
    echo "" >> $HeaderFile
    echo "#ifndef ${UpperName}_H" >> $HeaderFile
    echo "#define ${UpperName}_H" >> $HeaderFile

    echo "" >> $HeaderFile
    echo "namespace ${NameSpace}{" >> $HeaderFile
    echo "" >> $HeaderFile
    echo "class $ClassName{" >>$HeaderFile
    echo "  public:" >>$HeaderFile
    echo "    ${ClassName}(); " >>$HeaderFile
    echo "    ~${ClassName}(); " >>$HeaderFile
    echo "" >> $HeaderFile
    echo "  private:" >>$HeaderFile
    echo "    ${ClassName}(const ${ClassName}&);" >> $HeaderFile
    echo "    void operator=(const ${ClassName}&);" >> $HeaderFile
    echo "};"                >>$HeaderFile

    echo "" >> $HeaderFile
    echo "} //namespace" >> $HeaderFile

    echo "" >>$HeaderFile
    echo "#endif" >> $HeaderFile
    echo "" >>$HeaderFile
}

function GenerateCCFile(){
    touch $CCFile
    echo "#include \"${ClassName}.h\"" >>$CCFile
    echo "namespace ${NameSpace}{" >>$CCFile
    echo "}" >>$CCFile
    echo "" >> $CCFile
}

CheckExist $HeaderFile
CheckExist $CCFile

GenerateHeader
GenerateCCFile
