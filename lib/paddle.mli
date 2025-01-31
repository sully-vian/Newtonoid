open Params

module Make (P : PARAMS) : sig
  (** [Paddle.t] représente la raquette du joueur.
    - [x] est l'abscisse du coin inférieur gauche de la raquette.
    - [y] est l'ordonnée du coin inférieur gauche de la raquette.
    - [w] est la largeur de la raquette.
    - [h] est la hauteur de la raquette.
    - [vx] est la vitesse de déplacement horizontal de la raquette. *)
  type t =
    { x : float
    ; y : float
    ; w : float
    ; h : float
    ; vx : float
    }

  (** [make] crée une raquette correspondant aux paramètres décris dans le module [P] *)
  val make : t

  (** [update mouse_x paddle ] met à jour la position de la raquette [paddle] en fonction de l'abscisse de la souris [mouse_x]. *)
  val update : Box.Make(P).t -> float -> t -> t

  (** [draw p] dessine la raquette [p] en noir. *)
  val draw : t -> unit

  (** [draw_shadow p] dessine l'ombre de la raquette [p] en gris. *)
  val draw_shadow : t -> unit
end
