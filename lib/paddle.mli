(** [Paddle.t] représente la raquette du joueur. *)
type t = Rectangle.t

(** [make x y w h] crée une raquette de largeur [w] et de hauteur [h] avec [x,y] pour coordonnées du coin inférieur gauche *)
val make : float -> float -> float -> float -> t

(** [update box mouse_x paddle ] met à jour la position de la raquette [p] en fonction de l'abscisse de la souris [mouse_x] sans sortir de l'environnement de jeu [box]. *)
val update : Box.t -> float -> t -> t

(** [draw p] dessine la raquette [p] en noir. *)
val draw : t -> unit
