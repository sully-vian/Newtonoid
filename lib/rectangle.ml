(* x, y, largeur, hauteur *)
type rectangle = float * float * float * float

let make_rectangle : float -> float -> float -> float -> rectangle =
 fun x y width height -> x, y, width, height
;;
