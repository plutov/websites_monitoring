open Lwt
open Cohttp
open Cohttp_lwt_unix

type crawl_result = {
  url: string;
  success: bool;
  started_at: int;
  completed_at: int;
  status_code: int;
}

let crawl_url(url: string) =
  Printf.printf "Crawling %s ...\n" url;
  let uri = Uri.of_string url in
  Client.get uri >>= fun (resp, _) ->
  let code = resp |> Response.status |> Code.code_of_status in
  match code with
  | 200 -> return code
  | _ -> raise (Failure "Non 200 status code")


let crawl_website(w: Config.website) : crawl_result =
  let start_time = Unix.gettimeofday() in
  try
    let code = Lwt_main.run (crawl_url w.url) in
    let end_time = Unix.gettimeofday() in
    { url = w.url; success = true; started_at = int_of_float start_time; completed_at = int_of_float end_time; status_code = code }
  with | _ ->
    let end_time = Unix.gettimeofday() in
    { url = w.url; success = false; started_at = int_of_float start_time; completed_at = int_of_float end_time; status_code = 500 }
