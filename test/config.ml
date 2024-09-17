open Monitoring

let test_get_websites_from_file () =
  let websites = Config.get_websites_from_file "test_websites.yaml" in
  assert (List.length websites = 2);

  let first = List.hd websites in
  assert (first.url = "https://ocaml.org");
  assert (first.interval = 20)

let () =
  Unix.chdir "../../../test/";
  test_get_websites_from_file ();
