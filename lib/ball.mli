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

(** [make x y r vx vy] Crée une balle de centre [x, y], de rayon [r] et de vitesse [vx,vy] avec 3 points de vie. *)
val make : float -> float -> float -> float -> float -> t

(** [move b dx dy] Déplace la balle [b] de [dx] en abscisse et de [dy] en ordonnée. *)
val move : t -> float -> float -> t

(** [update b dt] Met à jour la position de la balle [b] en fonction du temps écoulé [dt] en secondes. *)
val update : t -> float -> t

(** [draw b] Dessine en noir la balle [b] sur l'écran. *)
val draw : t -> unit
