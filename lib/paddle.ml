type t =
  { x : float
  ; y : float
  ; w : float
  ; h : float
  }

let make x y w h = { x; y; w; h }
let update p mouse_x =
  { p with x = mouse_x }

let draw p =
  Graphics.set_color Graphics.black;
  Graphics.fill_rect
    (int_of_float (p.x -. (p.w /. 2.)))
    (int_of_float (p.y -. (p.h /. 2.)))
    (int_of_float p.w)
    (int_of_float p.h)
;;
