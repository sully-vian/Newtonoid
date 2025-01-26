open Libnewtonoid

module P = Params.Make (struct
  let config_filename = "../../../configs/default.conf"
end)

module BALL = Ball.Make (P)
open BALL

let%test_module "BALL.make" =
  (module struct
    let ball = BALL.make

    let%test "initial ball x" =
      let expected_x = P.paddle_x +. (P.paddle_w /. 2.) in
      ball.x = expected_x
    ;;

    let%test "initial ball y" =
      let expected_y = P.paddle_y +. P.paddle_h +. P.ball_r in
      ball.y = expected_y
    ;;

    let%test "initial ball r" = ball.r = P.ball_r
    let%test "initial ball vx" = ball.vx = 0.
    let%test "initial ball vy" = ball.vy = P.ball_init_vy
    let%test "initial ball pv" = ball.pv = P.ball_pv
  end)
;;

let%test_module "BALL.move" =
  (module struct
    let%test "move ball 1" =
      let ball = { make with vx = 12.; vy = 34. } in
      let ball' = move ball in
      ball'
      = { ball with
          x = ball.x +. (12. *. P.dt)
        ; y = ball.y +. (34. *. P.dt)
        ; vy = ball.vy +. (P.g *. P.dt)
        }
    ;;

    let%test "move ball 2" =
      let ball = { make with vx = -12.; vy = -34. } in
      let ball' = move ball in
      ball'
      = { ball with
          x = ball.x +. (-12. *. P.dt)
        ; y = ball.y +. (-34. *. P.dt)
        ; vy = ball.vy +. (P.g *. P.dt)
        }
    ;;

    let%test "move ball 3" =
      let ball = { make with vx = 0.; vy = 0. } in
      let ball' = move ball in
      ball'
      = { ball with
          x = ball.x +. (0. *. P.dt)
        ; y = ball.y +. (0. *. P.dt)
        ; vy = ball.vy +. (P.g *. P.dt)
        }
    ;;

    let%test "move ball 4" =
      let ball = { make with vx = 5.; vy = 10. } in
      let ball' = move ball in
      ball'
      = { ball with
          x = ball.x +. (5. *. P.dt)
        ; y = ball.y +. (10. *. P.dt)
        ; vy = ball.vy +. (P.g *. P.dt)
        }
    ;;

    let%test "move ball 5" =
      let ball = { make with vx = -5.; vy = -10. } in
      let ball' = move ball in
      ball'
      = { ball with
          x = ball.x +. (-5. *. P.dt)
        ; y = ball.y +. (-10. *. P.dt)
        ; vy = ball.vy +. (P.g *. P.dt)
        }
    ;;

    let%test "move ball 6" =
      let ball = { make with vx = 3.; vy = -7. } in
      let ball' = move ball in
      ball'
      = { ball with
          x = ball.x +. (3. *. P.dt)
        ; y = ball.y +. (-7. *. P.dt)
        ; vy = ball.vy +. (P.g *. P.dt)
        }
    ;;
  end)
;;

let%test_module "BALL.bound_speed" =
  (module struct
    let%test "bound_speed x " =
      let ball = { make with vx = 0.; vy = 0. } in
      let ball' = bound_speed ball in
      ball' = ball
    ;;

    let%test "bound_speed vx positive" =
      let ball = { make with vx = P.ball_max_vx +. 1.; vy = 0. } in
      let ball' = bound_speed ball in
      ball'.vx = P.ball_max_vx && ball'.vy = ball.vy
    ;;

    let%test "bound_speed vx negative" =
      let ball = { make with vx = -.P.ball_max_vx -. 1.; vy = 0. } in
      let ball' = bound_speed ball in
      ball'.vx = -.P.ball_max_vx && ball'.vy = ball.vy
    ;;

    let%test "bound_speed vy positive" =
      let ball = { make with vx = 0.; vy = P.ball_max_vy +. 1. } in
      let ball' = bound_speed ball in
      ball'.vx = ball.vx && ball'.vy = P.ball_max_vy
    ;;

    let%test "bound_speed vy negative" =
      let ball = { make with vx = 0.; vy = -.P.ball_max_vy -. 1. } in
      let ball' = bound_speed ball in
      ball'.vx = ball.vx && ball'.vy = -.P.ball_max_vy
    ;;

    let%test "bound_speed within limits" =
      let ball = { make with vx = P.ball_max_vx -. 1.; vy = P.ball_max_vy -. 1. } in
      let ball' = bound_speed ball in
      ball' = ball
    ;;
  end)
;;
