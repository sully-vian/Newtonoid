open Iterator
open Params

(** [State.t] représente un état du jeu à partir de la balle, du niveau et du
  score *)
type t =
  { ball : Ball.t
  ; level : Level.t
  ; score : int
  ; paddle : Paddle.t
  }

module Make (P : PARAMS) : sig
  (** [update box dt paddle state] met à jour l'état [state] (collisions, score etc) pour la fenêtre de jeu [box] et le taux [dt]. *)
  val update : Box.t -> float -> float * 'a -> t -> t

  (** [is_alive state] renvoie [true] si la balle a encore des points de vie et false sinon. *)
  val is_alive : t -> bool

  (** [make_flux box dt mouse_flux initial_state] crée le flux complet d'états à partir des différents éléments de l'environnement [box], [dt], [mouse_flux] et l'état initial [initial_state] *)
  val make_flux : Box.t -> float -> (float * 'a) Flux.t -> t -> t Flux.t

  (** [draw state] dessine l'état [state] *)
  val draw : t -> unit
end
