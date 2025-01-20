(** [char_list_of_channel chan] lit tous les caractères d'un canal d'entrée [chan] et les renvoie sous forme de liste. *)
val char_list_of_channel : in_channel -> char list

(** [parse_key_value_pairs chan] lit les paires clé-valeur d'un canal d'entrée [chan] et les renvoie sous forme de liste. *)
val parse_key_value_pairs : in_channel -> (string * string) list

(** [color_of_string str] convertit une chaîne de caractères [str] de la forme "r g b" en une couleur Graphics. *)
val color_of_string : string -> Graphics.color

(** [assoc l k] renvoie la valeur associée à la clé [k] dans la liste d'associations [l] et arrête le programme si la clé n'est pas trouvée. *)
val assoc : (string * 'a) list -> string -> 'a

(** [assoc_int l k] renvoie la valeur associée à la clé [k] dans la liste d'associations [l] et arrête le programme si la clé n'est pas trouvée ou si la valeur n'est pas un entier. *)
val assoc_int : (string * string) list -> string -> int

(** [assoc_float l k] renvoie la valeur associée à la clé [k] dans la liste d'associations [l] et arrête le programme si la clé n'est pas trouvée ou si la valeur n'est pas un flottant. *)
val assoc_float : (string * string) list -> string -> float

(** [assoc_color l k] renvoie la valeur associée à la clé [k] dans la liste d'associations [l] et arrête le programme si la clé n'est pas trouvée ou si la valeur n'est pas une couleur. *)
val assoc_color : (string * string) list -> string -> Graphics.color
