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
  match f with
  | Ok value ->
    (match websites_of_yaml value with
    | Ok t ->
      t.websites
    | Error `Msg e -> raise (Invalid_argument ("Invalid config format: " ^ e)))
  | Error `Msg e -> raise (Invalid_argument ("Unable to parse yaml file: " ^ e))
