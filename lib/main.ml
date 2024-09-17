module T = Domainslib.Task

let get_config_filename: string =
  try
    let path = Sys.getenv "CONFIG" in
    path
  with Not_found ->
    "./websites.yaml"

let rec run_async (website: Config.website) () =
  (* crawl website and store the result in the db *)
  let res = Crawler.crawl_website website in
  Database.insert_website res;

  (* wait for the next interval *)
  let _ = Unix.sleep website.interval in
  run_async website ()

let main () =
  let websites = get_config_filename |> Config.get_websites_from_file in
  Printf.printf "Websites found in config: %d\n" (List.length websites);

  let num_domains = Domain.recommended_domain_count () - 1 in
  Printf.printf "Number of domains/cores: %d\n" num_domains;

  (* create a pool and process each website concurrently *)
  let pool = T.setup_pool ~num_domains:(num_domains) () in
  T.run pool (fun _ ->
    List.iter (fun website ->
      let _ = T.async pool (run_async website) in
      ()
    ) websites
  );
  T.teardown_pool pool;

  print_endline "Exiting..."
