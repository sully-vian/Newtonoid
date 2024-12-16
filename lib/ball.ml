(* xball, yball, radius *)
type ball = (float * float * float)

let make : float -> float -> float -> ball =
  fun xball yball rball -> xball, yball, rball
;;

let draw : ball -> unit =
  fun (xball, yball, rball) ->
  Graphics.fill_circle
    (int_of_float xball)
    (int_of_float yball)
    (int_of_float rball)
;;