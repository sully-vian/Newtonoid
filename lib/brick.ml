(* xmin, xmax, ymin, ymax, pv, score *)
type brick = float * float * float * float * int * int

let make_brick : float -> float -> float -> float -> int -> int -> brick =
 fun xmin xmax ymin ymax pv score-> xmin, xmax, ymin, ymax, pv, score
