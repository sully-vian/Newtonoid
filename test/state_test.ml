open Libnewtonoid

module P = Params.Make (struct
  let config_filename = "../../../configs/default.conf"
end)

module STATE = State.Make (P)
open STATE

(* TODO *)