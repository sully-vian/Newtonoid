open Params

(** [Level.t] représente un niveau par une liste de briques. *)
type t = Brick.t list

module Make (P : PARAMS) : sig
  (** [make l] crée un niveau à partir de la liste de briques [l]. *)
  val make : Brick.t list -> t

  (** [draw l] dessine le niveau [l]. *)
  val draw : t -> unit

  (** [example_level] est un exemple de niveau. *)
  val example_level : t
end
