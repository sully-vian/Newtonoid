open Params

(** [brick_kind] représente les différentes types de briques. Ils définissent le nombre de pv initaux et l'xp gagnée à la destruction de la brique. *)
type brick_kind =
  | Weak
  | Standard
  | Strong
  | Unbreakable

(** [Brick.t] représente une brique par un rectangle [rect], un type de brique [kind] et un nombre de point de vie [pv]. *)
type t =
  { rect : Rectangle.t
  ; kind : brick_kind
  ; pv : int
  }

module Make (P : PARAMS) : sig
  (** [xp brick] donne le nombre d'xp gagnées à la destruction de la brique [brick] *)
  val xp : t -> int

  (** [make rect kind] crée une brique à partir d'un rectangle [rect] et d'une sorte de brique [kind]. *)
  val make : Rectangle.t -> brick_kind -> t

  (** [is_alive ball] renvoie [true] si la brique [ball] est encore en vie, c'est-à-dire si elle a encore des pv et sinon [false] *)
  val is_alive : t -> bool

  (** [damage dmg brick] renvoie une brique avec [dmg] pv en moins. *)
  val damage : int -> t -> t

  (** [draw brick] dessine la brique [brick].  Le dessin d'une brique comporte un contour noir et un rectangle interne coloré de taille proportionnelle aux pv restants. *)
  val draw : t -> unit
end
