FROM ocaml/opam:alpine AS init-opam

RUN sudo apk add gmp-dev sqlite-dev

FROM init-opam AS ocaml-app-base
WORKDIR /home/opam/websites_monitoring
COPY . .
RUN opam install . --deps-only
RUN opam install dune
RUN opam exec -- dune build

FROM alpine AS ocaml-app

COPY --from=ocaml-app-base /home/opam/websites_monitoring/_build/install/default/bin/monitoring /home/app/monitoring
RUN sudo apk add gmp-dev sqlite-dev

WORKDIR /home/app

ENTRYPOINT ["/home/app/monitoring"]
