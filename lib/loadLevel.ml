let char_list_of_string s = List.of_seq (String.to_seq s)

let char_list_list_of_channel chan =
  let rec aux acc =
    try
      let line = input_line chan in
      aux (char_list_of_string line :: acc)
    with
    | End_of_file -> List.rev acc
  in
  aux []
;;

(* -1 si de longueurs différentes, sinon, la longueur *)
let line_lengths lines =
  match lines with
  | [] -> 0
  | h :: t ->
    let len = List.length h in
    if List.exists (fun l -> List.length l <> len) t then
      -1
    else
      len
;;

(* check que line correspond à la regex "|-*|" *)
let check_border_line line =
  match line with
  | [] -> false
  | '|' :: t ->
    (match List.rev t with
     | '|' :: middle -> List.for_all (fun c -> c = '-') middle
     | _ -> false)
  | _ -> false
;;

(* check que line correspond à la regex "|.*|" *)
let check_line line =
  match line with
  | [] -> false
  | '|' :: t ->
    (match List.rev t with
     | '|' :: _ -> true
     | _ -> false)
  | _ -> false
;;

(* obtenir les dimensions du niveau *)
let get_dimensions lines =
  let width = line_lengths lines - 2 in
  if width = -1 then (
    print_string "Invalid level: some lines have different lengths\n";
    exit 1
  ) else (
    let height = List.length lines - 2 in
    width, height
  )
;;

let rec char_list_of_channel chan =
  try
    let c = input_char chan in
    c :: char_list_of_channel chan
  with
  | End_of_file -> []
;;
