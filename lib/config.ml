type website = {
  url : string;
  interval: int;
  pattern: string; [@default ""]
} [@@deriving yaml]

type websites = {
  websites: website list;
} [@@deriving yaml]

let get_websites_from_file(config_filename: string) : website list =
  let f = Yaml_unix.of_file Fpath.(v config_filename) in

  let yaml_value = match f with
  | Ok value -> value
  | Error `Msg e -> raise (Invalid_argument ("Unable to open/parse yaml file: " ^ e))
  in

  match websites_of_yaml yaml_value with
  | Ok t ->
    t.websites
  | Error `Msg e -> raise (Invalid_argument ("Invalid config format: " ^ e))
