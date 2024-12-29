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
    ; vy = P.ball_init_vy
    ; pv = P.ball_pv
    }

  let move ball =
    { ball with x = ball.x +. (ball.vx *. P.dt); y = ball.y +. (ball.vy *. P.dt) }

  let bound_speed ball =
    (* on borne vx *)
    let vx' =
      if ball.vx < -.P.ball_max_vx then
        -.P.ball_max_vx
      else if ball.vx > P.ball_max_vx then
        P.ball_max_vx
      else
        ball.vx
    in
    (* on borne vy *)
    let vy' =
      if ball.vy < -.P.ball_max_vy then
        -.P.ball_max_vy
      else if ball.vy > P.ball_max_vy then
        P.ball_max_vy
      else
        ball.vy
    in
    { ball with vx = vx'; vy = vy' }

  let draw ball =
    Graphics.(
      set_color P.ball_color;
      fill_circle (int_of_float ball.x) (int_of_float ball.y) (int_of_float ball.r))

  let draw_shadow ball =
    Graphics.(
      set_color P.shadow_color;
      fill_circle
        (int_of_float ball.x + 10)
        (int_of_float ball.y - 10)
        (int_of_float ball.r))
end
