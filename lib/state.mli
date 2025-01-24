open Iterator
open Params

module Make (P : PARAMS) : sig
  (** [game_status] représente le status du jeu (en cours ou initialisation) *)
  type game_status =
    | Init
    | Playing
    | GameOver
    | Victory
    | Paused

  (** [State.t] représente un état du jeu à partir de la balle, du niveau et du
  score *)
  type t =
    { ball : Ball.Make(P).t
    ; level : Level.Make(P).t
    ; score : int
    ; paddle : Paddle.Make(P).t
    ; status : game_status
    }

  (** [make level] crée un état initial du jeu avec les paramètres de [P], le niveau [level] et le score actuel *)
  val make : Level.Make(P).t -> int -> t

  (** [update mouse state] met à jour l'état du jeu [state] (collisions, score etc) pour l'état de la souris [mouse]. *)
  val update : float * bool -> t -> t

  (** [is_alive state] renvoie [true] si la balle a encore des points de vie et false sinon. *)
  val is_alive : t -> bool

  (** [make_flux mouse_flux initial_state] crée le flux complet d'états à partir du flux de la souris [mouse_flux] et l'état initial [initial_state] *)
  val make_flux : (float * bool) Flux.t -> t -> t Flux.t

  (** [draw state] dessine l'état [state] *)
  val draw : t -> unit
end
