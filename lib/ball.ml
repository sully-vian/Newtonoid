type t =
  { x : float
  ; y : float
  ; r : float
  ; vx : float
  ; vy : float
  }

let make x y r = { x; y; r; vx = 0.; vy = 0. }
let move b dx dy = { b with x = b.x +. dx; y = b.y +. dy }
let update b dt = move b (b.vx *. dt) (b.vy *. dt)

let draw b =
  Graphics.set_color Graphics.black;
  Graphics.fill_circle (int_of_float b.x) (int_of_float b.y) (int_of_float b.r)
;;
