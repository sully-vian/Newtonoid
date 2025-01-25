(** [unfold f flux e] est une sorte de [Flux.unfold] où [f] prend un second argument issu de [flux]. On l'utilise ici pour créer le flux d'états qui doit être généré avec les méthodes de mise-à-jour ET avec le flux de la souris. Son utilisation est moins abstraite si on explicite son type comme tel: [('mouse -> 'state -> 'state option) -> 'mouse Flux.t -> 'level list -> 'state -> 'state Flux.t] *)

val unfold2 : ('a -> 'b -> 'b option) -> 'a Iterator.Flux.t -> 'b -> 'b Iterator.Flux.t

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
