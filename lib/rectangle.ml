(* x, y, largeur, hauteur *)
type rectangle = float * float * float * float

let make : float -> float -> float -> float -> rectangle =
  fun x y width height -> x, y, width, height
;;

let draw : rectangle -> unit =
  fun (x, y, width, height) ->
  Graphics.fill_rect
    (int_of_float x)
    (int_of_float y)
    (int_of_float width)
    (int_of_float height)
;;
