let get_config_filename: string =
  try
    let path = Sys.getenv "CONFIG" in
    path
  with Not_found ->
    "./websites.yaml"

let get_db_filename: string =
  try
    let path = Sys.getenv "DB_NAME" in
    path
  with Not_found ->
    "./websites.sqlite3"

let main () =
  (* let db_file = get_db_filename in
  let db = Database.connect(db_file);*)

  let websites = get_config_filename |> Config.get_websites_from_file in
  Printf.printf "Websites found in config: %d\n" (List.length websites);

  (* iterate over websites and start a new thread for each website *)
  List.iter (fun website ->
    let _ = Thread.create Crawler.crawl_website website in ()
  ) websites;

  print_endline "Exiting..."
