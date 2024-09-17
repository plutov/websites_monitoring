FROM ocaml/opam:alpine AS init-opam

RUN sudo apk add --update gmp-dev sqlite-dev linux-headers openssl-dev curl-dev libcurl curl

FROM init-opam AS ocaml-app-base
WORKDIR /home/opam/websites_monitoring
COPY . .
RUN opam install . --deps-only
RUN opam install dune
RUN opam exec -- dune build

ENTRYPOINT ["/home/opam/websites_monitoring/_build/install/default/bin/monitoring"]
