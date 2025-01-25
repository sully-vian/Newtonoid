open Params

module Make (P : PARAMS) : sig
  (** [Level.t] représente un niveau par une liste de briques. *)
  type t =
    { bricks : Brick.Make(P).t list
    ; box : Box.Make(P).t
    }

  (** [make bricks box] crée un niveau à partir de la liste de briques [bricks] et de l'espace de jeu [box]. *)
  val make : Brick.Make(P).t list -> Box.Make(P).t -> t

  (** [make_brick x y kind] crée une brique de type [kind] aux coordonnées [x] et [y] de largeur/hauteur définies par [P]. *)
  val make_brick : float -> float -> Brick.Make(P).brick_kind -> Brick.Make(P).t

  (** [is_finished level] retourne [true] ssi le niveau [level] est vide ou ne contient que des briques incassables. *)
  val is_finished : t -> bool

  (** [draw l] dessine le niveau [l]. *)
  val draw : t -> unit

  (** [draw_shadow l] dessine l'ombre du niveau [l]. *)
  val draw_shadow : t -> unit

  (** [dims filename] retourne les dimensions du niveau stocké dans le fichier [filename]. Le résultat est en pixel, obtenue avec la dimensions des briques (cf [P]) et le nombre de briques (cf le fichier). *)
  val dims : string -> float * float

  (** [example_level] est un exemple de niveau. *)
  val example_level : t

  (** [load filename] charge un niveau à partir d'un fichier. *)
  val load : string -> t
end
