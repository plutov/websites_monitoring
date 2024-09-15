type website = {
  url : string;
  interval: int;
  pattern: string;
}

let read_lines filename =
  let contents = In_channel.with_open_bin filename In_channel.input_all in
  String.split_on_char '\n' contents

let get_websites_from_file(filename: string) : website list =
  (* return list with one element*)
  [ { url = filename; interval = 10; pattern = "google" } ]
