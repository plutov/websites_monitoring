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
  let websites = get_config_filename |> Config.get_websites_from_file in
  Printf.printf "Websites found in config: %d\n" (List.length websites);
  let first_website = List.hd websites in
  let res = Crawler.crawl_website first_website in
  (* print status code as string*)
  res.status_code |> string_of_int |> print_endline;
