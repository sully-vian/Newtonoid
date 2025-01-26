open Libnewtonoid

module P = Params.Make (struct
  let config_filename = "../../../configs/default.conf"
end)

module PADDLE = Paddle.Make (P)
module BOX = Box.Make (P)
open PADDLE

let%test_module "PADDLE.make" =
  (module struct
    let paddle = PADDLE.make

    let%test "initial paddle x" = paddle.x = P.paddle_x
    let%test "initial paddle y" = paddle.y = P.paddle_y
    let%test "initial paddle w" = paddle.w = P.paddle_w
    let%test "initial paddle h" = paddle.h = P.paddle_h
    let%test "initial paddle vx" = paddle.vx = 0.
  end)
;;

let%test_module "PADDLE.update" =
  (module struct
    let box = BOX.make 0. 0. 100. 100.
    let paddle = PADDLE.make

    let%test "update paddle position" =
      let mouse_x = 50. in
      let updated_paddle = PADDLE.update box mouse_x paddle in
      updated_paddle.x = mouse_x -. (paddle.w /. 2.)

    let%test "update paddle velocity" =
      let mouse_x = 50. in
      let updated_paddle = PADDLE.update box mouse_x paddle in
      updated_paddle.vx = (updated_paddle.x -. paddle.x) /. P.dt
  end)
;;