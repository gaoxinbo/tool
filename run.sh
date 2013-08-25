#!/bin/bash

function green(){
  echo -e "\033[32m"$1
}

function yellow(){
  echo -e "\033[33m"$1
}
function red(){

  echo -e "\033[31m"$1
}
function end(){
  echo -e "\033[0m"
}

yellow "starting to install cpp tool" 
end
(cd cpp;make install >/dev/null 2>&1) 

if [ "$?" != "0" ];then
  red "  install cpp tool error" 
  end
else
  green "  install cpp successed"
  end
fi

yellow "starting to install go tool"
end
(cd go;./run.sh)

if [ "$?" != "0" ];then
  red "  install go tool error"
  end
else
  green "  install go tool succeed"
  end
fi


yellow "starting to install python tool"
end
(cd python;./run.sh)

if [ "$?" != "0" ];then
  red "  install py tool error"
  end
else
  green "  install py tool succeed"
  end
fi


