
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
	"log"
)

func index(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "<h1>Hello World</h1>")
}

func check(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "<h1>Health check</h1>")
}

func resource(w http.ResponseWriter, r *http.Request) {
    body, err := ioutil.ReadFile("logs/resource.log")
    if err != nil {
        log.Fatalf("unable to read file: %v", err)
    }
    fmt.Fprintf(w, string(body))
}

func main() {
	http.HandleFunc("/", index)
	http.HandleFunc("/health_check", check)
	http.HandleFunc("/resource", resource)	
	fmt.Println("Server starting...")
	http.ListenAndServe(":3000", nil)

}


func check_err(e error) {
    if e != nil {
        panic(e)
    }
}