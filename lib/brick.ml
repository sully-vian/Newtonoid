open Rectangle

(* rectangle, (pv, xp) *)
type brick = rectangle * (int * int)

let make_brick : rectangle -> int -> int -> brick =
 fun rect pv xp -> rect, (pv, xp)
;;
