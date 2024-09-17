## Websites Checker in OCaml

This is a simple daemon that checks multiple websites concurrently and logs the statuses into SQLite database.

### Configuration

websites.yaml:

```yaml
websites:
  - url: https://packagemain.tech
    interval: 10
  - url: https://pliutau.com
    interval: 15
  - url: https://news.ycombinator.com
    interval: 30
```

### Setup OCaml if you haven't


```bash
brew install opam
opam init
opam install ocaml-lsp-server odoc ocamlformat utop
opam switch create ocaml-base-compiler
```

### Build the executable

```bash
opam install . --deps-only
dune build
```

### Run the executable

```bash
CONFIG=./websites.yaml \
DB_NAME=./websites.sqlite3 \
./_build/install/default/bin/monitoring
```

### Build & Run with Docker

```bash
docker build -t monitoring .

docker run \
-v $(pwd)/websites.yaml:/home/ocaml/websites.yaml \
-v $(pwd)/websites.sqlite3:/home/ocaml/websites.sqlite3 \
-e CONFIG=/home/ocaml/websites.yaml \
-e DB_NAME=/home/ocaml/websites.sqlite3 \
monitoring
```

### Run tests

```bash
dune runtest
```
