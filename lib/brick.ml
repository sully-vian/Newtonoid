type t =
  { rect : Rectangle.t
  ; pv : int
  ; xp : int
  }

let make rect pv xp = { rect; pv; xp }

let color b =
  match b.xp with
  | 5 -> Graphics.green
  | 10 -> Graphics.blue
  | 20 -> Graphics.red
  | 50 -> Graphics.yellow
  | 100 -> Graphics.cyan
  | _ -> Graphics.black
;;

let draw b =
  Graphics.set_color (color b);
  Rectangle.draw b.rect
;;
