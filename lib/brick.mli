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

  (** [get_init_pv kind] donne le nombre de points de vie initial de la brique de type [kind] tel que défini dans [P]. *)
  val get_init_pv : brick_kind -> int

  (** [get_xp brick] donne le nombre de points d'expérience gagnés à la destruction de la brique [brick] tel que défini dans [P]. *)
  val get_xp : t -> int

  (** [make x y w h kind] crée une brique à partir des coordonnées [x,y] du coin inférieur gauche, de la largeur [w], de la hauteur [h] et d'une sorte de brique [kind]. *)
  val make : float -> float -> float -> float -> brick_kind -> t

  (** [get_color brick] donne la couleur de la brique [brick] telle que définie dans [P] *)
  val get_color : t -> Graphics.color

  (** [is_alive ball] renvoie [true] si la brique [ball] a au moins un point de vie et sinon [false] *)
  val is_alive : t -> bool

  (** [damage dmg brick] renvoie une brique identique à [brick] avec [dmg] pv en moins. *)
  val damage : int -> t -> t

  (** [inner_rect brick] renvoie les coordonnées [x,y,w,h] du rectangle interne de la brique [brick], de dimensions proportionnelles aux pv restants et centré dans la brique. *)
  val inner_rect : t -> float * float * float * float

  (** [draw brick] dessine la brique [brick].  Le dessin d'une brique comporte un contour noir et un rectangle interne coloré de taille proportionnelle aux pv restants. *)
  val draw : t -> unit

  (** [draw_shadow brick] dessine l'ombre de la brique. *)
  val draw_shadow : t -> unit
end
