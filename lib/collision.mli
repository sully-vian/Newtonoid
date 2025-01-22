open Params

module Make (P : PARAMS) : sig

  (** [with_brick ball brick] renvoie le couple [ball, brick] après collision de la balle avec la brique eux (si collision il y a). *)
  val with_brick : Ball.Make(P).t -> Brick.Make(P).t -> Ball.Make(P).t * Brick.Make(P).t

  (** [with_level ball level score] renvoie le tuple [ball, level, score] après les collisions de la balle [ball] avec les briques du niveau [level] et mise-à-jour du score [score] (si collision il y a). *)
  val with_level
    :  Ball.Make(P).t
    -> Level.Make(P).t
    -> int
    -> Ball.Make(P).t * Level.Make(P).t * int

  (** [with_box ball] renvoie la balle [ball] après collision avec les bords de la fenêtre de jeu (si collision il y a). *)
  val with_box : Ball.Make(P).t -> Ball.Make(P).t

  (** [with_paddle ball paddle] renvoie la balle [ball] après collision avec la raquette [paddle] (si collision il y a). *)
  val with_paddle : Ball.Make(P).t -> Paddle.Make(P).t -> Ball.Make(P).t
end
