open Params

module Make (P : PARAMS) = struct
  type brick_kind =
    | Weak
    | Standard
    | Strong
    | Unbreakable

  type t =
    { x : float
    ; y : float
    ; w : float
    ; h : float
    ; kind : brick_kind
    ; pv : int
    }

  let get_init_pv kind =
    match kind with
    | Weak -> P.brick_weak_pv
    | Standard -> P.brick_standard_pv
    | Strong -> P.brick_strong_pv
    | Unbreakable -> 1 (* symbolique *)
  ;;

  let get_xp brick =
    match brick.kind with
    | Weak -> P.brick_weak_xp
    | Standard -> P.brick_standard_xp
    | Strong -> P.brick_strong_xp
    | Unbreakable -> 0 (* symbolique *)
  ;;

  let make x y w h kind = { x; y; w; h; kind; pv = get_init_pv kind }

  let get_color brick =
    match brick.kind with
    | Weak -> P.brick_weak_color
    | Standard -> P.brick_standard_color
    | Strong -> P.brick_strong_color
    | Unbreakable -> P.brick_unbreakable_color
  ;;

  let is_alive brick = brick.pv > 0

  let damage dmg brick =
    if brick.kind = Unbreakable then
      brick
    else
      { brick with pv = brick.pv - dmg }
  ;;

  let inner_rect brick =
    let r = float_of_int brick.pv /. float_of_int (get_init_pv brick.kind) in
    let x' = brick.x +. (brick.w *. (1. -. r) /. 2.) in
    let y' = brick.y +. (brick.h *. (1. -. r) /. 2.) in
    let w' = brick.w *. r in
    let h' = brick.h *. r in
    x', y', w', h'
  ;;

  let draw brick =
    let open Graphics in
    set_color (get_color brick);
    let x', y', w', h' = inner_rect brick in
    fill_rect (int_of_float x') (int_of_float y') (int_of_float w') (int_of_float h');
    set_color P.borders_color;
    draw_rect
      (int_of_float brick.x)
      (int_of_float brick.y)
      (int_of_float brick.w)
      (int_of_float brick.h)
  ;;

  let draw_shadow brick =
    let open Graphics in
    set_color P.shadow_color;
    let x', y', w', h' = inner_rect brick in
    fill_rect
      (int_of_float x' + P.shadow_offset_x)
      (int_of_float y' + P.shadow_offset_y)
      (int_of_float w')
      (int_of_float h');
    draw_rect
      (int_of_float brick.x + P.shadow_offset_x)
      (int_of_float brick.y + P.shadow_offset_y)
      (int_of_float brick.w)
      (int_of_float brick.h)
  ;;
end
