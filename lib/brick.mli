(** [brick_kind] représente les différentes types de briques. Ils définissent
  le nombre de pv initaux et l'xp gagnée à la destruction de la brique.
  - [Weak] : 1 pv, 5 xp
  - [Standard] : 2 pv, 10 xp
  - [Strong] : 3 pv, 20 xp
  - [Unbreakable] : résistance infinie, 0 xp *)
type brick_kind =
  | Weak
  | Standard
  | Strong
  | Unbreakable

(** [Brick.t] représente une brique par un rectangle [rect], un type de brique
  [kind] et un nombre de point de vie [pv]. *)
type t =
  { rect : Rectangle.t
  ; kind : brick_kind
  ; pv : int
  }

(** [make rect kind] crée une brique à partir d'un rectangle [rect] et d'une
    sorte de brique [kind]. *)
val make : Rectangle.t -> brick_kind -> t

(** [color b] renvoie la couleur associée à l'xp délivrée par la brique [b]. *)
val color : t -> Graphics.color

(** [draw b] dessine la brique [b] de la couleur associée à son type. *)
val draw : t -> unit
