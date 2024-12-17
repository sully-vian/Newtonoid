(** [collision ball brick] renvoie le couple [ball, brick] après collision entre
  eux (si collision il y a). *)
val ball_brick : Ball.t -> Brick.t -> Ball.t * Brick.t

(** [collision ball level score] renvoie le tuple [ball, level, score] après les
    collisions de la balle [ball] avec les briques du niveau [level] et
    mise-à-jour du score [score] (si collision il y a). *)
val ball_level : Ball.t -> Brick.t list -> int -> Ball.t * Level.t * int

(** [collision ball box] renvoie la balle [ball] après collision avec les bords
  de la fenêtre de jeu [box] (si collision il y a). *)
val ball_box : Ball.t -> Box.t -> Ball.t
