package main

import (
    "os"
    "io/ioutil"
    "github.com/russross/blackfriday"
    "fmt"
    "net/http"
    "path"
    //"path/filepath"
    )

func handler(w http.ResponseWriter, r *http.Request){
  filename := path.Join(root ,r.URL.Path[1:])
  file,err := os.Open(filename)
  if err != nil{
    fmt.Fprintf(w,err.Error())
    return
  }

  info,err := file.Stat()
  if err != nil{
    fmt.Fprint(w,err.Error())
    return
  }

  if info.IsDir(){
    children,err := file.Readdir(0)
    if err != nil{
      fmt.Fprint(w,err.Error())
      return
    }

    fmt.Fprintf(w,"<html>")
    for _,child := range(children){
      name := child.Name()
      if len(name) <= 0 || name[0] == '.' {
        continue
      }else{
        related := path.Join(filename,child.Name())
        related = related[len(root):]
        fmt.Println(related)
        fmt.Fprintf(w,"<a href=\"/%s\">%s</a><p/>",related,child.Name())
      }
    }
    fmt.Fprintf(w,"</html>")
  }else{
    data,err := ioutil.ReadAll(file)
      if err != nil{
        fmt.Fprintf(w,err.Error())
        return
      }
    output := string(blackfriday.MarkdownBasic(data))

    fmt.Fprintf(w,"<html> %s </html>", output)

  }


}

var root="/Users/gaoxinbo/Desktop/note/"
func main(){
  http.HandleFunc("/",handler)
    http.ListenAndServe(":9090",nil)
    /*
       file,err := os.Open("/Users/gaoxinbo/Desktop/note/resume.md")
       if err != nil{
       panic(err)
       }

     */
}
