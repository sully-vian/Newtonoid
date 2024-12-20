open Params

module Make (P : PARAMS) = struct
  type t =
    { x : float
    ; y : float
    ; r : float
    ; vx : float
    ; vy : float
    ; pv : int
    }

  let make =
    { x = P.ball_x; y = P.ball_y; r = P.ball_r; vx = 200.; vy = 200.; pv = P.ball_pv }
  ;;

  let move ball =
    { ball with x = ball.x +. (ball.vx *. P.dt); y = ball.y +. (ball.vy *. P.dt) }
  ;;

  let draw b =
    Graphics.set_color Graphics.black;
    Graphics.fill_circle (int_of_float b.x) (int_of_float b.y) (int_of_float b.r);
    Graphics.moveto 200 20;
    Graphics.draw_string (Format.sprintf "ballvx: %f" b.vx)
  ;;
end
