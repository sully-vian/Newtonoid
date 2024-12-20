open Params

type t =
  { x : float
  ; y : float
  ; r : float
  ; vx : float
  ; vy : float
  ; pv : int
  }

module Make (P : PARAMS) = struct
  let make x y r = { x; y; r; vx = 200.; vy = 200.; pv = 3 }

  let move ball dt =
    { ball with x = ball.x +. (ball.vx *. dt); y = ball.y +. (ball.vy *. dt) }
  ;;

  let draw b =
    Graphics.set_color Graphics.black;
    Graphics.fill_circle (int_of_float b.x) (int_of_float b.y) (int_of_float b.r);
    Graphics.moveto 200 20;
    Graphics.draw_string (Format.sprintf "ballvx: %f" b.vx)
  ;;
end
