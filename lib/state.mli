open Iterator
open Params

module Make (P : PARAMS) : sig
  (** [game_status] représente le status du jeu (en cours ou initialisation) *)
  type game_status =
    | Init
    | Playing
    | GameOver
    | Victory

  (** [State.t] représente un état du jeu à partir de la balle, du niveau et du
  score *)
  type t =
    { ball : Ball.Make(P).t
    ; level : Level.Make(P).t
    ; score : int
    ; paddle : Paddle.Make(P).t
    ; status : game_status
    }

  (** [update box mouse state] met à jour l'état du jeu [state] (collisions, score etc) pour l'état de la souris [mouse] et fenêtre de jeu [box]. *)
  val update : Box.Make(P).t -> float * bool -> t -> t

  (** [is_alive state] renvoie [true] si la balle a encore des points de vie et false sinon. *)
  val is_alive : t -> bool

  (** [make_flux box mouse_flux initial_state] crée le flux complet d'états à partir des différents éléments de l'environnement [box], [mouse_flux] et l'état initial [initial_state] *)
  val make_flux : Box.Make(P).t -> (float * bool) Flux.t -> t -> t Flux.t

  (** [draw state] dessine l'état [state] *)
  val draw : t -> unit
end
