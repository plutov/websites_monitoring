(lang dune 3.16)

(name websites_monitoring)

(generate_opam_files true)

(source
 (github plutov/websites_monitoring))

(authors "@pliutau")

(license "MIT")

(maintainers "@pliutau")

(package
 (name websites_monitoring)
 (synopsis "Check the list of websites for availability")
 (depends
    ocaml
    dune
    yaml
    domainslib
    ezcurl
    sqlite3
    ppx_deriving_yaml))
