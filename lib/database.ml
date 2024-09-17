open Sqlite3

let get_db_filename: string =
  try
    let path = Sys.getenv "DB_NAME" in
    path
  with Not_found ->
    "./websites.sqlite3"

let connection = db_open get_db_filename

let create_table_sql = "
create table if not exists websites ( \
	id integer primary key autoincrement not null, \
	started_at integer not null, \
	completed_at integer not null, \
	status integer not null default 0, \
	url text not null \
);"

let insert_website(website: Crawler.crawl_result) =
  let insert_sql = Printf.sprintf "insert into websites (started_at, completed_at, status, url) values (%d, %d, %d, '%s')"
  website.started_at website.completed_at website.status_code website.url in
  match exec connection insert_sql with
  | Rc.OK -> Printf.printf "Stored website crawl status: %s\n" website.url
  | _ -> Printf.printf "Failed to store website crawl status: %s\n" website.url

let () =
  match exec connection create_table_sql with
  | Rc.OK -> print_endline "Database table created"
  | _ -> raise (Failure "Failed to create database table")
