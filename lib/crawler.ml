type crawl_result = {
  url: string;
  success: bool;
  started_at: int;
  completed_at: int;
  status_code: int;
}

let crawl_url(url: string): int =
  let res = Ezcurl.get ~url () in
  match res with
  | Ok response -> response.code
  | Error _ -> 500


let crawl_website(w: Config.website) : crawl_result =
  let start_time = Unix.gettimeofday() in
  let url = w.url in
  let res = Ezcurl.get ~url () in
  let status_code = match res with
  | Ok response -> response.code
  | Error _ -> 500
  in
  let end_time = Unix.gettimeofday() in
  { url = w.url; success = true; started_at = int_of_float start_time; completed_at = int_of_float end_time; status_code = status_code }
