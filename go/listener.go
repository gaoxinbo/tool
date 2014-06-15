package main

import (
    "fmt"
    "net/http"
    )

func handler(w http.ResponseWriter, r *http.Request) {
  fmt.Fprint(w,"<html>")
  fmt.Fprint(w,"<body>")

  fmt.Fprint(w,"URL:")
  fmt.Fprint(w,r.URL)
  for key, value := range r.Header {
    fmt.Fprint(w,"<p>")
    fmt.Fprint(w,key,":");
    for index,_:= range value {
      fmt.Fprint(w,value[index])
    }
    fmt.Fprint(w,"</p>")
  }
  fmt.Fprint(w,"</body>")
  fmt.Fprint(w,"</html>")
}


func main() {
  http.HandleFunc("/",handler)
  http.ListenAndServe(":8000",nil)
}
