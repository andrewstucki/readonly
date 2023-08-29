package main

import (
	"log"
	"os"
)

func main() {
	if err := os.WriteFile("/tmp/test", []byte("test"), 0777); err != nil {
		log.Fatal(err)
	}
}
