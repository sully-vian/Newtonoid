(** [collision ball brick] renvoie la balle après collision avec le rectangle
    [r] (si collision il y a). *)
val ball_brick : Ball.t -> Brick.t -> Ball.t

(** [collision ball box] renvoie la balle après collision avec les bords de la
      fenpetre de jeu [b] (si collision il y a). *)
val ball_box : Ball.t -> Box.t -> Ball.t
