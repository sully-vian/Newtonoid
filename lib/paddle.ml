open Rectangle
open Iterator

type t = Rectangle.t

let make x y w h = { x; y; w; h }

let make_flux (box : Box.t) paddle =
  let bounded_x x_mouse =
    let x = x_mouse -. (paddle.w /. 2.) in
    if x < box.infx then
      box.infx
    else if x +. paddle.w > box.supx then
      box.supx -. paddle.w
    else
      x
  in
  let generate (x_mouse, _) = { paddle with x = bounded_x x_mouse } in
  Flux.cons paddle (Flux.map generate Input.mouse)
;;

let update paddle mouse_x = { paddle with x = mouse_x }

let draw paddle =
  Graphics.set_color Graphics.black;
  Graphics.fill_rect
    (int_of_float paddle.x)
    (int_of_float paddle.y)
    (int_of_float paddle.w)
    (int_of_float paddle.h)
;;
