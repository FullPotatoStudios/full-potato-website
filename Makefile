TAILWIND = tailwindcss-linux-x64

.PHONY: tailwind-get
tailwind-get:
	curl -sLO https://github.com/tailwindlabs/tailwindcss/releases/latest/download/$(TAILWIND)
	chmod +x $(TAILWIND) 
	mv $(TAILWIND)   tailwindcss

.PHONY: air-get
air-get:
	curl -sSfL https://raw.githubusercontent.com/cosmtrek/air/master/install.sh | sudo sh -s -- -b $(go env GOPATH)/bin

.PHONY: deps
deps:
	make air-get
	go mod download

.PHONY: tailwind-watch
tailwind-watch:
	./tailwindcss -i ./web/static/css/input.css -o ./web/static/css/style.css --watch

.PHONY: tailwind-build
tailwind-build:
	./tailwindcss -i ./web/static/css/input.css -o ./web/static/css/style.css --minify

.PHONY: templ-generate
templ-generate:
	templ generate

.PHONY: templ-watch
templ-watch:
	templ generate --watch

.PHONY: build
build:
	make tailwind-build && make templ-generate && go build -o ./bin/server ./cmd/server/main.go