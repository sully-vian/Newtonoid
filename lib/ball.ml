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
    let paddle_middle = P.paddle_x +. (P.paddle_w /. 2.) in
    let paddle_top = P.paddle_y +. P.paddle_h in
    { x = paddle_middle
    ; y = paddle_top +. P.ball_r
    ; r = P.ball_r
    ; vx = 0.
    ; vy = 200.
    ; pv = P.ball_pv
    }
  ;;

  let move ball =
    { ball with x = ball.x +. (ball.vx *. P.dt); y = ball.y +. (ball.vy *. P.dt) }
  ;;

  let draw b =
    Graphics.(
      set_color black;
      fill_circle (int_of_float b.x) (int_of_float b.y) (int_of_float b.r))
  ;;
end
