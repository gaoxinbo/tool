#!/bin/bash

function green(){
  echo -e "\033[32m"$1
}

function red(){
  echo -e "\033[31m"$1
}
function end(){
  echo -e "\033[0m"
}

red "installing cpp tool" 
end
(cd cpp;make install >/dev/null 2>&1) 

if [ "$?" != "0" ];then
  red "install cpp tool" 
  end
else
  green "install cpp successed"
  end
fi

red "install go tool"
end
(cd go;./run.sh)

if [ "$?" != "0" ];then
  red "install go tool error"
  end
else
  green "install go tool succeed"
  end
fi

