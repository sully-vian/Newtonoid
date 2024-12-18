type t = Rectangle.t

let make x y w h = Rectangle.{ x; y; w; h }

(* TODO *)
let update box mouse_x paddle =
  Box.(
    let min_x = box.infx in
    let max_x = box.supx -. Rectangle.(paddle.w) in
    let x' = min max_x (max min_x (mouse_x -. (Rectangle.(paddle.w) /. 2.))) in
    Rectangle.{ paddle with x = x' })
;;

let draw paddle =
  Rectangle.(
    Graphics.(
      set_color black;
      fill_rect
        (int_of_float paddle.x)
        (int_of_float paddle.y)
        (int_of_float paddle.w)
        (int_of_float paddle.h)))
;;
