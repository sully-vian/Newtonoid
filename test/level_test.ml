open Libnewtonoid

module P = Params.Make (struct
  let config_filename = "../../../configs/default.conf"
end)

module LEVEL = Level.Make (P)
open LEVEL

(* TODO *)
