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

  (** [make infx infy supx supy] crée une fenêtre de jeu de dimensions [infx] [infy] [supx] [supy] et de marge P.box_marge. *)
  val make : float -> float -> float -> float -> t

  (** [resize_window box] redimensionne la fenêtre de jeu à partir de [box]. *)
  val resize_window : t -> unit

  (** [middle box] renvoie les coordonnées du milieu de la fenêtre de jeu [box]. *)
  val middle : t -> int * int

  (** [draw box] dessine les contours de l'aire de jeu [box] *)
  val draw : t -> unit
end
