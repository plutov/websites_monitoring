let get_config_filename: string =
  try
    let path = Sys.getenv "CONFIG" in
    path
  with Not_found ->
    "websites.yaml"

let main () =
  let config_filename = get_config_filename in
  let websites = Config.get_websites_from_file(config_filename) in
  let len = List.length websites in
  let len_str = Printf.sprintf "%d" len in
  print_endline len_str;;
