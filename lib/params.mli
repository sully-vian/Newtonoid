module type PARAMS = sig
  (* Ball params *)
  val ball_x : float
  val ball_y : float
  val ball_r : float
  val ball_pv : int

  (* Box params *)
  val box_marge : float
  val box_infx : float
  val box_infy : float
  val box_supx : float
  val box_supy : float

  (* Brick params *)
  val brick_weak_pv : int
  val brick_standard_pv : int
  val brick_strong_pv : int
  val brick_unbreakable_pv : int
  val brick_weak_xp : int
  val brick_standard_xp : int
  val brick_strong_xp : int
  val brick_unbreakable_xp : int

  (* Level params *)
  val brick_w : float
  val brick_h : float

  (* Paddle params *)
  val paddle_x : float
  val paddle_y : float
  val paddle_w : float
  val paddle_h : float

  (* General params *)
  val dt : float
end

module Default : PARAMS
