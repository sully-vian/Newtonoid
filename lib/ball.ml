type t =
  { x : float
  ; y : float
  ; r : float
  ; vx : float
  ; vy : float
  ; pv : int
  }

let make x y r vx vy = { x; y; r; vx; vy; pv = 3 }
let move b dx dy = { b with x = b.x +. dx; y = b.y +. dy }
let update b dt = move b (b.vx *. dt) (b.vy *. dt)

let draw b =
  Graphics.set_color Graphics.black;
  Graphics.fill_circle (int_of_float b.x) (int_of_float b.y) (int_of_float b.r)
;;
