open Ball
open Rectangle

(* TODO *)
(* Renvoie true si la balle est en collision avec le rectangle *)
let collision : ball -> rectangle -> bool =
 fun (x, y, r) (x', y', width, height) ->
  let x1 = x -. r in
  let x2 = x +. r in
  let y1 = y -. r in
  let y2 = y +. r in
  let x1' = x' in
  let x2' = x' +. width in
  let y1' = y' in
  let y2' = y' +. height in
  x1 <= x2' && x2 >= x1' && y1 <= y2' && y2 >= y1'
;;
