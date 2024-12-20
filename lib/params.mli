module type PARAMS = sig
  val x : float
  val y : float
  val r : float
  val vx : float
  val vy : float
  val pv : int
end

module Default : PARAMS
