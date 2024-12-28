module type PARAMS = sig
  val ball_r : float
  val ball_pv : int
  val ball_init_vy : float
  val ball_max_vx : float
  val ball_max_vy : float
  val box_marge : float
  val box_infx : float
  val box_infy : float
  val box_supx : float
  val box_supy : float
  val brick_weak_pv : int
  val brick_standard_pv : int
  val brick_strong_pv : int
  val brick_weak_xp : int
  val brick_standard_xp : int
  val brick_strong_xp : int
  val brick_w : float
  val brick_h : float
  val paddle_x : float
  val paddle_y : float
  val paddle_w : float
  val paddle_h : float
  val dt : float
  val ball_color : Graphics.color
  val paddle_color : Graphics.color
  val shadow_color : Graphics.color
end

module Default : PARAMS = struct
  let ball_r = 10.
  let ball_pv = 3
  let ball_init_vy = 200.
  let ball_max_vx = 500.
  let ball_max_vy = 200.
  let box_marge = 10.
  let box_infx = 10.
  let box_infy = 10.
  let box_supx = 800.
  let box_supy = 600.
  let brick_weak_pv = 3
  let brick_standard_pv = 5
  let brick_strong_pv = 10
  let brick_weak_xp = 5
  let brick_standard_xp = 10
  let brick_strong_xp = 20
  let brick_w = 50.
  let brick_h = 30.
  let paddle_x = 20.
  let paddle_y = 50.
  let paddle_w = 100.
  let paddle_h = 5.
  let dt = 1. /. 60.
  let ball_color = Graphics.black
  let paddle_color = Graphics.black
  let shadow_color = Graphics.rgb 200 200 200
end
