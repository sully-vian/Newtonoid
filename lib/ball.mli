(** [Ball.t] représente une balle.
    - [x] est l'abscisse du centre de la balle.
    - [y] est l'ordonnée du centre de la balle.
    - [vx] est la vitesse horizontale de la balle.
    - [vy] est la vitesse verticale de la balle.
    - [r] est le rayon de la balle. *)
type t =
  { x : float
  ; y : float
  ; r : float
  ; vx : float
  ; vy : float
  }

(** [make x y r] Crée une balle de rayon [r] de centre ([x], [y]) et de vitesse nulle. *)
val make : float -> float -> float -> t

(** [move b dx dy] Déplace la balle [b] de [dx] en abscisse et de [dy] en ordonnée. *)
val move : t -> float -> float -> t

(** [update b dt] Met à jour la position de la balle [b] en fonction du temps écoulé [dt] en secondes. *)
val update : t -> float -> t

(** [draw b] Dessine en noir la balle [b] sur l'écran. *)
val draw : t -> unit
