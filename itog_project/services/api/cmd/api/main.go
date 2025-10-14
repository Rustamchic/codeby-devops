package main
import ("fmt";"log";"net/http";"os")
func main(){mux:=http.NewServeMux()
mux.HandleFunc("/healthz",func(w http.ResponseWriter,r *http.Request){w.WriteHeader(200);_,_=w.Write([]byte("ok"))})
mux.HandleFunc("/",func(w http.ResponseWriter,r *http.Request){name:=os.Getenv("APP_NAME");if name==""{name="myapp-api"};_,_=w.Write([]byte(fmt.Sprintf("Hello from %s!\n",name)))})
addr:=":8080";log.Printf("listening on %s",addr);log.Fatal(http.ListenAndServe(addr,mux))}
