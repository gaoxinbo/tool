#include "netdb.h"
#include "stdio.h"
#include "errno.h"
#include <string.h>
#include "arpa/inet.h"
#include <iostream>
using namespace std;

int main(int argc, char **argv){
  if(argc == 1){
    cout<<"input a hostname"<<endl;
    return 1;
  }
  hostent * host = gethostbyname(argv[1]);
  if(host == NULL){
    cout<<"get host error "<<strerror(errno)<<endl;
  }

  cout<<"Result of "<<argv[1]<<endl;

  cout<<"offcial : "<<endl;
  cout<<"  "<<host->h_name<<endl;
  

  char ** pptr = host->h_addr_list;
  cout<<"address : "<<endl;
  for(;*pptr!=NULL;pptr++){
    char buf[32];
    inet_ntop(AF_INET,*pptr,buf,32);
    cout<<"  "<<buf<<endl;
  }

  cout<<"alias : "<<endl;
  pptr= host->h_aliases;
  for(;*pptr!=NULL;pptr++){
    cout<<"  "<<*pptr<<endl;
  }
  return 0;
}
