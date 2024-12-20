open Params

module Make (P : PARAMS) : sig
(** [Box.t] représente la fenêtre de jeu avec
    - [marge] : marge entre la fenêtre et l'écran
    - [infx] : abscisse minimale
    - [infy] : ordonnée minimale
    - [supx] : abscisse maximale
    - [supy] : ordonnée maximale *)
type t =
  { marge : float
  ; infx : float
  ; infy : float
  ; supx : float
  ; supy : float
  }

  (** [make] crée une fenêtre de jeu avec les paramètres de [P]. *)
  val make : t

  (** [draw box] dessine les contours de l'aire de jeu [box] *)
  val draw : t -> unit
end
