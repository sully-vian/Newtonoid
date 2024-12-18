(* pour interpréter le fichier *)
let char_to_brick c =
  match c with
  | '-' -> Some Brick.Weak
  | '=' -> Some Brick.Standard
  | '#' -> Some Brick.Strong
  | ' ' -> None
  | _ -> failwith (Format.sprintf "The character \"%c\" is not allowed." c)
;;

let read_file file_name =
  let chan = open_in file_name in
  ()
;;
