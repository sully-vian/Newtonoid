open Libnewtonoid

module P = Params.Make (struct
  let config_filename = "../../../configs/default.conf"
end)

module PADDLE = Paddle.Make (P)
open PADDLE

(* TODO *)