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

let make rect kind =
  match kind with
  | Weak -> { rect; kind; pv = 1 }
  | Standard -> { rect; kind; pv = 2 }
  | Strong -> { rect; kind; pv = 3 }
  | Unbreakable -> { rect; kind; (* résistance "infinie" *) pv = max_int }
;;

let color b =
  match b.kind with
  | Weak -> Graphics.rgb 255 0 0
  | Standard -> Graphics.rgb 255 255 0
  | Strong -> Graphics.rgb 0 255 0
  | Unbreakable -> Graphics.rgb 0 0 255
;;

let draw b =
  Graphics.set_color (color b);
  Rectangle.draw b.rect
;;
