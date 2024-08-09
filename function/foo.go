package function

import "net/http"

func Foo(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("Hello, World!"))
}
