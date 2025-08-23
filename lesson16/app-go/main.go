package main
import (
 "fmt"
 "log"
 "net/http"
)
func main() {
 http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
  w.Header().Set("Content-Type", "text/html; charset=utf-8")
  fmt.Fprintln(w, "<h1>lesson16: multistage Go app</h1>")
 })
 log.Fatal(http.ListenAndServe(":8080", nil))
}
