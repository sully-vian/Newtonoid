(** [Ball.t] représente une balle.
    - [x] est l'abscisse du centre de la balle.
    - [y] est l'ordonnée du centre de la balle.
    - [r] est le rayon de la balle.
    - [vx] est la vitesse horizontale de la balle.
    - [vy] est la vitesse verticale de la balle.
    - [pv] est le nombre de points de vie du joueur *)
type t =
  { x : float
  ; y : float
  ; r : float
  ; vx : float
  ; vy : float
  ; pv : int
  }

(** [make x y r] Crée une balle de centre [x, y], de rayon [r] et de vitesse nulle avec 3 points de vie. *)
val make : float -> float -> float -> t

(** [move ball dt] déplace la balle [ball] en fonction du temps écoulé [dt] en secondes. *)
val move : t -> float -> t

(** [draw ball] Dessine en cercle noir la balle [ball] sur l'écran. *)
val draw : t -> unit
