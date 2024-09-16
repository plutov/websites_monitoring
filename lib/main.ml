module T = Domainslib.Task

let get_config_filename: string =
  try
    let path = Sys.getenv "CONFIG" in
    path
  with Not_found ->
    "./websites.yaml"

let main () =
  let websites = get_config_filename |> Config.get_websites_from_file in
  Printf.printf "Websites found in config: %d\n" (List.length websites);

  let num_domains = Domain.recommended_domain_count () - 1 in
  Printf.printf "Number of domains/cores: %d\n" num_domains;

  let pool = T.setup_pool ~num_domains:(num_domains - 1) () in
  T.teardown_pool pool;

  print_endline "Exiting..."
