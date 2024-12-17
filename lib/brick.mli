(** [Brick.t] représente une brique par un rectangle et un couple (pv, xp) *)
type t =
  { rect : Rectangle.t
  ; pv : int
  ; xp : int
  }

(** [make rect pv xp] crée une brique à partir d'un rectangle [rect], d'un
    nombre de points de vie [pv] et d'un multiplicateur de points [xp] *)
val make : Rectangle.t -> int -> int -> t

(** [color b] renvoie la couleur associée à l'xp délivrée par la brique [b] *)
val color : t -> Graphics.color

(** [draw b] dessine la brique [b] de la couleur associée à son xp *)
val draw : t -> unit
