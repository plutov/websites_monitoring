type website = {
  url : string;
  interval: int;
  pattern: string;
}

let read_lines filename =
  let contents = In_channel.with_open_bin filename In_channel.input_all in
  String.split_on_char '\n' contents

let get_websites_from_file(config_filename: string) : website list =
  let y = Yaml_unix.of_file Fpath.(v config_filename) in
  let x = match y with
    | Ok v -> v
    | Error _ -> raise (Invalid_argument "Invalid yaml config file")
  in
  let s = Yaml.to_string_exn x in
  (* return list with one element*)
  [ { url = s; interval = 10; pattern = "google" } ]
