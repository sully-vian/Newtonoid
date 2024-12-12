open Ball
open Brick

(* TODO *)
(* Renvoie true si la balle est en collision avec la brique *)
let collision : ball -> brick -> bool =
 fun (x, y, r) (xmin, xmax, ymin, ymax, _, _) -> true
;;
