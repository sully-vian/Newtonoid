(** [Paddle.t] représente la raquette du joueur. *)
type t = Rectangle.t

(** [make x y w h] crée une raquette de largeur [w] et de hauteur [h] avec un centre en [x, y]. *)
val make : float -> float -> float -> float -> t

(** [update p mouse_x] met à jour la position de la raquette [p] en fonction de l'abscisse de la souris [mouse_x]. *)
val update : t -> float -> t

(** [draw p] dessine la raquette [p] en noir. *)
val draw : t -> unit
