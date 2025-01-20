(** [char_list_of_channel chan] lit tous les caractères d'un canal d'entrée [chan] et les renvoie sous forme de liste. *)
let rec char_list_of_channel : in_channel -> char list =
 fun chan ->
  try
    let c = input_char chan in
    c :: char_list_of_channel chan
  with
  | End_of_file -> []
;;
