open Params

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

module Make (P : PARAMS) = struct
  module RECTANGLE = Rectangle.Make (P)

  let default_pv kind =
    match kind with
    | Weak -> 1
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
  let damage dmg brick = { brick with pv = brick.pv - dmg }

  let inner_rect brick =
    Rectangle.(
      let r = float_of_int brick.pv /. float_of_int (default_pv brick.kind) in
      let x' = brick.rect.x +. (brick.rect.w *. (1. -. r) /. 2.) in
      let y' = brick.rect.y +. (brick.rect.h *. (1. -. r) /. 2.) in
      let w' = brick.rect.w *. r in
      let h' = brick.rect.h *. r in
      RECTANGLE.make x' y' w' h')
  ;;

  let draw brick =
    let open Graphics in
    let open Rectangle in
    set_color (color brick);
    RECTANGLE.draw (inner_rect brick);
    set_color black;
    draw_rect
      (int_of_float brick.rect.x)
      (int_of_float brick.rect.y)
      (int_of_float brick.rect.w)
      (int_of_float brick.rect.h)
  ;;
end
