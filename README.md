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

```bash
brew install opam
opam init
```

### Usage

```bash
CONFIG=./websites.yaml \
DB_NAME=./websites.sqlite3 \
TODO
```

### Run tests

```bash
TODO
```
