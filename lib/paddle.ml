open Rectangle

type t = Rectangle.t

let make x y w h = { x; y; w; h }
let update paddle mouse_x = { paddle with x = mouse_x }

let draw p =
  Graphics.set_color Graphics.black;
  Graphics.fill_rect
    (int_of_float (p.x -. (p.w /. 2.)))
    (int_of_float (p.y -. (p.h /. 2.)))
    (int_of_float p.w)
    (int_of_float p.h)
;;
