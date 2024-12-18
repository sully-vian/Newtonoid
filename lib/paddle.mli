open Iterator

(** [Paddle.t] représente la raquette du joueur. *)
type t = Rectangle.t

(** [make x y w h] crée une raquette de largeur [w] et de hauteur [h] avec [x,y] pour coordonnées du coin inférieur gauche *)
val make : float -> float -> float -> float -> t

(** [make box paddle] crée un flux de raquettes commençant par [paddle] dont les positions successives sont centrées sur l'abscisse de la souris et ne débordent pas sur l'extérieur de l'aire de jeu [box] *)
val make_flux : Box.t -> t -> t Flux.t

(** [update p mouse_x] met à jour la position de la raquette [p] en fonction de l'abscisse de la souris [mouse_x]. *)
val update : t -> float -> t

(** [draw p] dessine la raquette [p] en noir. *)
val draw : t -> unit
