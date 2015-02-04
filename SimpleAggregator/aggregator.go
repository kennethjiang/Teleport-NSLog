package main

import (
    "net/http"
    "io/ioutil"
    "compress/gzip"
    "io"
    "os"
    "path"
    "bytes"
    "log"
)

func Handler(resp http.ResponseWriter, req *http.Request) {
    query := req.URL.Query()
    deviceid := query.Get("devid")
    log.Printf("Device id: %s", deviceid)
    if deviceid == "" {
        http.Error(resp, "devid is required parameter", http.StatusBadRequest)
        return
    }

    body, err := ioutil.ReadAll(req.Body)
    if err != nil {
        http.Error(resp, err.Error(), http.StatusInternalServerError)
        return
    }   
    
    r, err := gzip.NewReader(bytes.NewReader(body))
    if err != nil {
        http.Error(resp, err.Error(), http.StatusInternalServerError)
        return
    }   
    dst, err := os.OpenFile(path.Join("logs",deviceid), os.O_CREATE|os.O_APPEND|os.O_WRONLY,0600)
    log.Printf("Appending to %s", dst)
    if err != nil {
        http.Error(resp, err.Error(), http.StatusInternalServerError)
        return
    }
    defer dst.Close()
    defer r.Close()
    io.Copy(dst, r)
}

func main() {
    http.HandleFunc("/", Handler)
    http.ListenAndServe(":8080", nil)
}
