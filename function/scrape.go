package function

import "net/http"

func Scrape(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("Hello, World!"))
}
