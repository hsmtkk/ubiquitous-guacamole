package function

import (
	"github.com/GoogleCloudPlatform/functions-framework-go/functions"
)

func init() {
	functions.HTTP("Scrape", Scrape)
	functions.HTTP("Foo", Foo)
}
