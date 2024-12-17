(** [State.t] représente un état du jeu à partir de la balle, du niveau et du
  score *)
type t = Ball.t * Level.t * int

(** [update box dt state] met à jour l'état [state] (collisions, score etc) pour la fenêtre de jeu [box] et le taux [dt] *)
val update : Box.t -> float -> t -> t

(** [update2 box dt paddle state] met à jour l'état [state] (collisions, score etc) pour la fenêtre de jeu [box], le taux [dt] et la raquette [paddle]*)
val update2 : Box.t -> float -> Paddle.t -> t -> t

(** [draw state] dessine l'état [state] *)
val draw : t -> unit

(** [draw2 state] dessine l'état [state] et la raquette [paddle] *)
val draw2 : Paddle.t -> t -> unit
