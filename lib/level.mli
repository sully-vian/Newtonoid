open Params

module Make (P : PARAMS) : sig
  (** [Level.t] représente un niveau par une liste de briques. *)
  type t =
    { bricks : Brick.Make(P).t list
    ; box : Box.Make(P).t
    }

  (** [make bricks box] crée un niveau à partir de la liste de briques [bricks] et de l'espace de jeu [box]. *)
  val make : Brick.Make(P).t list -> Box.Make(P).t -> t

  (** [is_finished level] retourne [true] ssi le niveau [level] est vide ou ne contient que des briques incassables. *)
  val is_finished : t -> bool

  (** [draw l] dessine le niveau [l]. *)
  val draw : t -> unit

  (** [draw_shadow l] dessine l'ombre du niveau [l]. *)
  val draw_shadow : t -> unit

  (* TODO: doc *)
  val level_dims : string -> float * float

  (** [example_level] est un exemple de niveau. *)
  val example_level : t

  (** [load filename] charge un niveau à partir d'un fichier. *)
  val load : string -> t
end
