(** [with_brick ball brick] renvoie le couple [ball, brick] après collision de la balle avec la brique eux (si collision il y a). *)
val with_brick : Ball.t -> Brick.t -> Ball.t * Brick.t

(** [with_level ball level score] renvoie le tuple [ball, level, score] après les collisions de la balle [ball] avec les briques du niveau [level] et mise-à-jour du score [score] (si collision il y a). *)
val with_level : Ball.t -> Brick.t list -> int -> Ball.t * Level.t * int

(** [with_box ball box] renvoie la balle [ball] après collision avec les bords de la fenêtre de jeu [box] (si collision il y a). *)
val with_box : Ball.t -> Box.t -> Ball.t

(** [with_paddle ball paddle] renvoie la balle [ball] après collision avec la raquette [paddle] (si collision il y a). *)
val with_paddle : Ball.t -> Paddle.t -> Ball.t
