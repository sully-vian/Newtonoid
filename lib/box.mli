open Params

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

module Make (P : PARAMS) : sig
  (** [make marge infx infy supx supy] crée une fenêtre de jeu avec les paramètres donnés. *)
  val make : float -> float -> float -> float -> float -> t

  (** [draw box] dessine les contours de l'aire de jeu [box] *)
  val draw : t -> unit
end
