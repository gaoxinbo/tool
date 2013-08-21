package main

/*
   Pretty print files and directories in a specific directory
*/
import (
    "fmt"
    "os"
    "flag"
    "path"
    )


func print(dir, prefix string){

  file,err := os.Open(dir)
    if err != nil{
      panic(err)
    }

  items,err := file.Readdir(0)
    if err != nil{
      panic(err)
    }

  for _,value := range items{
    if value.IsDir(){
      fmt.Println(prefix,value.Name())
      print(path.Join(dir,value.Name()) ,prefix+"    ")
    }else{
      fmt.Println(prefix,value.Name())
    }
  }

}

func main(){
    path := flag.String("path","","directory to print")
    flag.Parse()

    if len(*path) == 0{
      fmt.Println("using current work directory")
      *path = os.Getenv("PWD")
    }

    print(*path,"")


}
