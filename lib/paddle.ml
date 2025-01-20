open Params

module Make (P : PARAMS) = struct
  module BOX = Box.Make (P)

  type t =
    { x : float
    ; y : float
    ; w : float
    ; h : float
    ; vx : float
    }

  let make = { x = P.paddle_x; y = P.paddle_y; w = P.paddle_w; h = P.paddle_h; vx = 0. }

  let update box mouse_x paddle =
    BOX.(
      let min_x = box.infx in
      let max_x = box.supx -. paddle.w in
      let x' = min max_x (max min_x (mouse_x -. (paddle.w /. 2.))) in
      let vx' = (x' -. paddle.x) /. P.dt in
      { paddle with x = x'; vx = vx' })
  ;;

  let draw paddle =
    Graphics.(
      set_color P.paddle_color;
      fill_rect
        (int_of_float paddle.x)
        (int_of_float paddle.y)
        (int_of_float paddle.w)
        (int_of_float paddle.h))
  ;;

  let draw_shadow paddle =
    Graphics.(
      set_color P.shadow_color;
      fill_rect
        (int_of_float paddle.x + 10)
        (int_of_float paddle.y - 10)
        (int_of_float paddle.w)
        (int_of_float paddle.h))
  ;;
end
