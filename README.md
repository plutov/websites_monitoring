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

### Prerequisites (macos example)

Takes a bit of time to install all the packages.

```bash
brew install opam
opam init
eval $(opam env)
opam install ocaml-lsp-server odoc ocamlformat utop
opam switch create ocaml-base-compiler
```

Project is created with this command:

```bash
dune init proj websites_checker_ocaml
```

### Usage

```bash
CONFIG=./websites.yaml \
DB_NAME=./websites.sqlite3 \
dune exec websites_checker_ocaml
```

### Run tests

```bash
TODO
```
