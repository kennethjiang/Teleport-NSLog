package main

import (
    "fmt"
    "net/http"
    "io/ioutil"
    "archive/zip"
    "io"
    "os"
    "path"
    "bytes"
)

func handler(resp http.ResponseWriter, req *http.Request) {
    query := req.URL.Query()
    deviceid := query.Get("devid")
    body, err := ioutil.ReadAll(req.Body)
    if err != nil {
        fmt.Println("Error: ", err)
    }   
    
    r, err := zip.NewReader(bytes.NewReader(body), req.ContentLength)
    if err != nil {
        fmt.Println("Error: ", err)
    }   
    for _, zf := range r.File {
        fmt.Println("filename: %s", zf.Name)
        dst, err := os.Create(path.Join("logs",deviceid))
        if err != nil {
            fmt.Println("Error: ", err)
        }
        defer dst.Close()
        src, err := zf.Open()
        if err != nil {
            fmt.Println("Error: ", err)
        }
        defer src.Close()
    
        io.Copy(dst, src)
    }   
}

func main() {
    http.HandleFunc("/", handler)
    http.ListenAndServe(":8080", nil)
}
