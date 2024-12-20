open Params

(** [Paddle.t] représente la raquette du joueur. *)
type t =
  { x : float
  ; y : float
  ; w : float
  ; h : float
  ; vx : float
  }

module Make (P : PARAMS) : sig
  (** [make x y w h vx] crée une raquette de largeur [w] et de hauteur [h] avec [x,y] pour coordonnées du coin inférieur gauche *)
  val make : float -> float -> float -> float -> float -> t

  (** [update box dt mouse_x paddle ] met à jour la position de la raquette [paddle] sans sortir de l'environnement de jeu [box], de taux de rafraichissement [dt] et en fonction de l'abscisse de la souris [mouse_x]. *)
  val update : Box.t -> float -> float -> t -> t

  (** [draw p] dessine la raquette [p] en noir. *)
  val draw : t -> unit
end
