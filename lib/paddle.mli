open Params

module Make (P : PARAMS) : sig
  (** [Paddle.t] représente la raquette du joueur. *)
  type t =
    { x : float
    ; y : float
    ; w : float
    ; h : float
    ; vx : float
    }

  (** [make] crée une raquette correspondant aux paramètres décris dans le module [P] *)
  val make : t

  (** [update box mouse_x paddle ] met à jour la position de la raquette [paddle] en fonction de l'abscisse de la souris [mouse_x] sans sortir de l'environnement de jeu [box]. *)
  val update : Box.Make(P).t -> float -> t -> t

  (** [draw p] dessine la raquette [p] en noir. *)
  val draw : t -> unit
end
