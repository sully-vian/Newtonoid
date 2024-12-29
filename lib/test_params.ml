open Params.Default

(* Ball params Tests *)
let%test "ball_r > 0" = ball_r > 0.
let%test "ball_pv > 0" = ball_pv > 0
let%test "ball_init_vy > 0" = ball_init_vy > 0.
let%test "ball_init_vy <= ball_max_vy" = ball_init_vy <= ball_max_vy
let%test "ball_max_vx > 0" = ball_max_vx > 0.
let%test "ball_max_vy > 0" = ball_max_vy > 0.

(* Box params Tests *)
let%test "box_marge > 0" = box_marge > 0.
let%test "box_infx = box_marge" = box_infx = box_marge
let%test "box_infy = box_marge" = box_infy = box_marge
let%test "box_supx > box_infx" = box_supx > box_infx
let%test "box_supy > box_infy" = box_supy > box_infy

(* Brick params Tests *)
let%test "brick_weak_pv > 0" = brick_weak_pv > 0
let%test "brick_standard_pv > brick_weak_pv" = brick_standard_pv > brick_weak_pv
let%test "brick_strong_pv > brick_standard_pv" = brick_strong_pv > brick_standard_pv
let%test "brick_weak_xp > 0" = brick_weak_xp > 0
let%test "brick_standard_xp > brick_weak_xp" = brick_standard_xp > brick_weak_xp
let%test "brick_strong_xp > brick_standard_xp" = brick_strong_xp > brick_standard_xp

(* Level params Tests *)
let%test "brick_w > 0" = brick_w > 0.
let%test "brick_h > 0" = brick_h > 0.

(* Paddle params Tests *)
let%test "paddle_x > 0" = paddle_x > 0.
let%test "paddle_y > 0" = paddle_y > 0.
let%test "paddle_w > 0" = paddle_w > 0.
let%test "paddle_h > 0" = paddle_h > 0.

(* General params Tests *)
let%test "dt > 0" = dt > 0.
