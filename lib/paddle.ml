type t =
  { x : float
  ; y : float
  ; w : float
  ; h : float
  ; vx : float
  }

let make x y w h vx = { x; y; w; h; vx }

(* TODO *)
let update box mouse_x paddle =
  Box.(
    let min_x = box.infx in
    let max_x = box.supx -. paddle.w in
    let x' = min max_x (max min_x (mouse_x -. (paddle.w /. 2.))) in
    let vx = (x' -. paddle.x) /. 10. in
    { paddle with x = x'; vx })
;;

let draw paddle =
  Graphics.(
    set_color black;
    fill_rect
      (int_of_float paddle.x)
      (int_of_float paddle.y)
      (int_of_float paddle.w)
      (int_of_float paddle.h);
    moveto 100 20;
    draw_string Format.(sprintf "vx: %f" paddle.vx))
;;
