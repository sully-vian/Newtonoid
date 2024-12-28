open Params

module Make (P : PARAMS) : sig
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

  (** [make] crée une balle avce les paramètres de [P] et de vitesse nulle. *)
  val make : t

  (** [move ball] déplace la balle [ball] en fonction de sa vitesse. *)
  val move : t -> t

  (** [bound_speed ball] renvoie la balle [ball] avec des vitesses rrespectant les bornes définies dans [P] *)
  val bound_speed : t -> t

  (** [draw ball] dessine un cercle centré sur les coordonnées de la balle [ball] de la couleur choisie dans [P]. *)
  val draw : t -> unit

  (** [draw_shadow ball] dessine  *)
  val draw_shadow : t -> unit
end
