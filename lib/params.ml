module type PARAMS = sig
  val x : float
  val y : float
  val r : float
  val vx : float
  val vy : float
  val pv : int
end

module Default : PARAMS = struct
  let x = 400.
  let y = 300.
  let r = 10.
  let vx = 0.
  let vy = 0.
  let pv = 3
end
