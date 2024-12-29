module type PARAMS = sig
  (* Ball params *)
  val ball_r : float
  val ball_pv : int
  val ball_init_vy : float
  val ball_max_vx : float
  val ball_max_vy : float

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
  val brick_weak_xp : int
  val brick_standard_xp : int
  val brick_strong_xp : int

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

  (* Colors *)
  val ball_color : Graphics.color
  val paddle_color : Graphics.color
  val brick_weak_color : Graphics.color
  val brick_standard_color : Graphics.color
  val brick_strong_color : Graphics.color
  val brick_unbreakable_color : Graphics.color
  val shadow_color : Graphics.color
end

module Default : PARAMS
