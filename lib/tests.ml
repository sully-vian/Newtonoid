module P = Params.Default
module BALL = Ball.Make (P)
module BRICK = Brick.Make (P)
module BOX = Box.Make (P)
module PADDLE = Paddle.Make (P)

(* Ball Tests *)
let%test "ball_make" =
  BALL.(
    let ball = make in
    ball.r = P.ball_r && ball.pv = P.ball_pv && ball.vx = 0. && ball.vy = P.ball_init_vy)

let%test "ball_move" =
  BALL.(
    let ball = { make with vx = 10.; vy = -10. } in
    let x' = ball.x +. (P.dt *. ball.vx) in
    let y' = ball.y +. (P.dt *. ball.vy) in
    move ball = { ball with x = x'; y = y' })

let%test "ball_move_with_0" =
  BALL.(
    let ball = { make with vx = 0.; vy = 0. } in
    let x' = ball.x +. (P.dt *. ball.vx) in
    let y' = ball.y +. (P.dt *. ball.vy) in
    move ball = { ball with x = x'; y = y' })

let%test "ball_bound_speed_max" =
  BALL.(
    let ball = { make with vx = P.ball_max_vx +. 1.; vy = P.ball_max_vy +. 1. } in
    bound_speed ball = { ball with vx = P.ball_max_vx; vy = P.ball_max_vy })

let%test "ball_bound_speed_min" =
  BALL.(
    let ball = { make with vx = -.P.ball_max_vx -. 1.; vy = -.P.ball_max_vy -. 1. } in
    bound_speed ball = { ball with vx = -.P.ball_max_vx; vy = -.P.ball_max_vy })

let%test "ball_bound_speed_0" =
  BALL.(
    let ball = { make with vx = 0.; vy = 0. } in
    bound_speed ball = ball)

(* Paddle Tests *)
let%test "paddle_make" =
  PADDLE.(
    make = { x = P.paddle_x; y = P.paddle_y; w = P.paddle_w; h = P.paddle_h; vx = 0. })

let%test "paddle_update" =
  let box = BOX.make in
  let mouse_x = 100. in
  let paddle = PADDLE.make in
  let paddle' = PADDLE.update box mouse_x paddle in
  PADDLE.(paddle'.x = mouse_x -. (paddle'.w /. 2.))

(* Brick Tests *)
let%test "box_make" =
  BOX.(
    make
    = { marge = P.box_marge
      ; infx = P.box_infx
      ; infy = P.box_infy
      ; supx = P.box_supx
      ; supy = P.box_supy
      })

(* Ball test *)
