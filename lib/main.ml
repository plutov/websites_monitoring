let get_config_filename: string =
  try
    let path = Sys.getenv "CONFIG" in
    path
  with Not_found ->
    "websites.yaml"

let main () =
  let config_filename = get_config_filename in
  let websites = Config.get_websites_from_file(config_filename) in
  let first_website = List.hd websites in
  print_endline first_website.url
