open Rectangle

(* rectangle, (pv, xp) *)
(* xp est le nombre de points raportés et pv est le nombre de point de vie restants *)
type brick = rectangle * (int * int)

let make : rectangle -> int -> int -> brick = fun rect pv xp -> rect, (pv, xp)

let color : int -> Graphics.color =
  fun xp ->
  match xp with
  | 1 -> Graphics.green
  | 2 -> Graphics.blue
  | 3 -> Graphics.red
  | 4 -> Graphics.yellow
  | _ -> Graphics.black
;;

let draw : brick -> unit =
  fun ((x, y, width, height), (_, xp)) ->
  Graphics.set_color (color xp);
  Graphics.fill_rect
    (int_of_float x)
    (int_of_float y)
    (int_of_float width)
    (int_of_float height)
;;
