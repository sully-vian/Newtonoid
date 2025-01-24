open Params

module Make (P : PARAMS) : sig
  (** [Level.t] représente un niveau par une liste de briques. *)
  type t = Brick.Make(P).t list

  (** [make l] crée un niveau à partir de la liste de briques [l]. *)
  val make : Brick.Make(P).t list -> t

  (** [is_finished level] retourne [true] ssi le niveau [level] est vide ou ne contient que des briques incassables. *)
  val is_finished : t -> bool

  (** [draw l] dessine le niveau [l]. *)
  val draw : t -> unit

  (** [draw_shadow l] dessine l'ombre du niveau [l]. *)
  val draw_shadow : t -> unit

  (** [example_level] est un exemple de niveau. *)
  val example_level : t

  (** [load_level filename] charge un niveau à partir d'un fichier. *)
  val load_level : Box.Make(P).t -> string -> t
end
