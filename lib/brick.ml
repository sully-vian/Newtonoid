type brick_kind =
  | Weak
  | Standard
  | Strong
  | Unbreakable

type t =
  { rect : Rectangle.t
  ; kind : brick_kind
  ; pv : int
  }

let default_pv kind =
  match kind with
  | Weak -> 2
  | Standard -> 5
  | Strong -> 10
  | Unbreakable -> max_int
;;

let xp brick =
  match brick.kind with
  | Weak -> 5
  | Standard -> 10
  | Strong -> 20
  | Unbreakable -> 0
;;

let make rect kind = { rect; kind; pv = default_pv kind }

let color b =
  match b.kind with
  | Weak -> Graphics.green
  | Standard -> Graphics.blue
  | Strong -> Graphics.red
  | Unbreakable -> Graphics.black
;;

let is_alive b = b.pv > 0

let inner_rect b =
  let r = float_of_int b.pv /. float_of_int (default_pv b.kind) in
  let x' = b.rect.x +. (b.rect.w *. (1. -. r) /. 2.) in
  let y' = b.rect.y +. (b.rect.h *. (1. -. r) /. 2.) in
  let w' = b.rect.w *. r in
  let h' = b.rect.h *. r in
  Rectangle.make x' y' w' h'
;;

let draw b =
  Graphics.set_color (color b);
  Rectangle.draw (inner_rect b);
  Graphics.set_color Graphics.black;
  Graphics.draw_rect
    (int_of_float b.rect.x)
    (int_of_float b.rect.y)
    (int_of_float b.rect.w)
    (int_of_float b.rect.h)
;;
