open Params

module Make (P : PARAMS) : sig
  (** [brick_kind] représente les différentes types de briques. Ils définissent le nombre de pv initaux et l'xp gagnée à la destruction de la brique. *)
  type brick_kind =
    | Weak
    | Standard
    | Strong
    | Unbreakable

  (** [Brick.t] représente une brique par un rectangle [rect], un type de brique [kind] et un nombre de point de vie [pv]. *)
  type t =
    { x : float
    ; y : float
    ; w : float
    ; h : float
    ; kind : brick_kind
    ; pv : int
    }

  (** [xp brick] donne le nombre d'xp gagnées à la destruction de la brique [brick] *)
  val xp : t -> int

  (** [make x y w h kind] crée une brique à partir des coordonnées [x,y] du coin inférieur gauche, de la largeur [w], de la hauteur [h] et d'une sorte de brique [kind]. *)
  val make : float -> float -> float -> float -> brick_kind -> t

  (** [is_alive ball] renvoie [true] si la brique [ball] est encore en vie, c'est-à-dire si elle a encore des pv et sinon [false] *)
  val is_alive : t -> bool

  (** [damage dmg brick] renvoie une brique avec [dmg] pv en moins. *)
  val damage : int -> t -> t

  (** [draw brick] dessine la brique [brick].  Le dessin d'une brique comporte un contour noir et un rectangle interne coloré de taille proportionnelle aux pv restants. *)
  val draw : t -> unit

  (** [draw_shadow brick] dessine l'ombre de la brique. *)
  val draw_shadow : t -> unit
end
