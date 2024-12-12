(* xball, yball, radius *)
type ball = (float * float * float)

let make_ball : float -> float -> float -> ball =
  fun xball yball rball -> xball, yball, rball