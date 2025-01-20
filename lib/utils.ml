let rec char_list_of_channel chan =
  try
    let c = input_char chan in
    c :: char_list_of_channel chan
  with
  | End_of_file -> []
;;

let parse_key_value_pairs chan =
  let rec aux chan acc =
    try
      let line =
        (* rien si ligne vide et on ignore tout après le # *)
        match String.split_on_char '#' (input_line chan) with
        | [] -> ""
        | h :: _ -> String.trim h
      in
      match String.split_on_char '=' line with
      | [ key; value ] ->
        let key = String.trim key in
        let value = String.trim value in
        aux chan ((key, value) :: acc)
      | _ -> aux chan acc
    with
    | End_of_file -> acc
  in
  aux chan []
;;

let color_of_string str =
  match String.split_on_char ' ' str with
  | [ r; g; b ] ->
    let r = int_of_string r in
    let g = int_of_string g in
    let b = int_of_string b in
    Graphics.rgb r g b
  | _ -> raise (Failure "color_of_string")
;;

let assoc l k =
  match List.assoc_opt k l with
  | Some v -> v
  | None ->
    print_string ("Error: key \"" ^ k ^ "\" not found in config file\n");
    exit 1
;;

let assoc_int l k =
  try int_of_string (assoc l k) with
  | Failure _ ->
    print_string ("Error: key \"" ^ k ^ "\" must be an integer\n");
    exit 1
;;

let assoc_float l k =
  try float_of_string (assoc l k) with
  | Failure _ ->
    print_string ("Error: key \"" ^ k ^ "\" must be a float\n");
    exit 1
;;

let assoc_color l k =
  try color_of_string (assoc l k) with
  | Failure _ ->
    print_string ("Error: key \"" ^ k ^ "\" must be a color (\"r g b\") \n");
    exit 1
;;
