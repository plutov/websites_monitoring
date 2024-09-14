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
    pattern: ocaml
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
opam install . --deps-only --with-doc --with-test
dune build
```

### Run the program
```bash
CONFIG=./websites.yaml \
DB_NAME=./websites.sqlite3 \
./_build/install/default/bin/monitoring
```

### Run tests

```bash
dune runtest
```
