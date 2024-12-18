(** [Rectangle.t] représente un rectangle par ses coordonnées et ses dimensions.
  *)
type t =
  { x : float
  ; y : float
  ; w : float
  ; h : float
  }

(** [make x y w h] crée un rectangle en [x, y] de largeur [w] et hauteur [h] *)
val make : float -> float -> float -> float -> t

(** [draw rect] dessine le rectangle [rect] avec [x, y] pour coordonnées du coin
  inférieur gauche *)
val draw : t -> unit
