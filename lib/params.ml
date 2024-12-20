module type PARAMS = sig
  val ball_r : float
  val ball_pv : int
  val box_marge : float
  val box_infx : float
  val box_infy : float
  val box_supx : float
  val box_supy : float
  val brick_weak_pv : int
  val brick_standard_pv : int
  val brick_strong_pv : int
  val brick_unbreakable_pv : int
  val brick_weak_xp : int
  val brick_standard_xp : int
  val brick_strong_xp : int
  val brick_unbreakable_xp : int
  val brick_w : float
  val brick_h : float
  val paddle_x : float
  val paddle_y : float
  val paddle_w : float
  val paddle_h : float
  val dt : float
end

module Default : PARAMS = struct
  let ball_r = 10.
  let ball_pv = 3
  let box_marge = 10.
  let box_infx = 10.
  let box_infy = 10.
  let box_supx = 800.
  let box_supy = 600.
  let brick_weak_pv = 1
  let brick_standard_pv = 5
  let brick_strong_pv = 10
  let brick_unbreakable_pv = max_int
  let brick_weak_xp = 5
  let brick_standard_xp = 10
  let brick_strong_xp = 20
  let brick_unbreakable_xp = 0
  let brick_w = 50.
  let brick_h = 30.
  let paddle_x = 20.
  let paddle_y = 50.
  let paddle_w = 100.
  let paddle_h = 20.
  let dt = 1. /. 60.
end
