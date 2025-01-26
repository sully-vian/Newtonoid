open Params

module Make (P : PARAMS) = struct
  module BRICK = Brick.Make (P)
  module BOX = Box.Make (P)

  type t =
    { bricks : BRICK.t list
    ; box : BOX.t
    ; filename : string
    }

  let make bricks box filename = { bricks; box; filename }
  let make_brick x y kind = BRICK.make x y P.brick_w P.brick_h kind

  let is_finished level =
    let rec aux bricks =
      match bricks with
      | [] -> true
      | h :: t ->
        if BRICK.(h.kind <> Unbreakable && is_alive h) then
          false
        else
          aux t
    in
    aux level.bricks
  ;;

  let draw { bricks; box; filename } =
    List.iter BRICK.draw bricks;
    BOX.draw box;
    Graphics.(
      (*set_font P.medium_font;*)
      let text_w, _ = text_size filename in
      moveto (size_x () - (text_w + int_of_float P.box_marge + 1)) (int_of_float P.box_marge);
      set_color P.text_color;
      draw_string filename)
  ;;

  let draw_shadow { bricks; _ } = List.iter BRICK.draw_shadow bricks

  let dims filename =
    let lvl_width, lvl_height =
      LoadLevel.get_dimensions (LoadLevel.char_list_list_of_channel (open_in filename))
    in
    float_of_int lvl_width *. P.brick_w, float_of_int lvl_height *. P.brick_h
  ;;

  let load filename =
    let open BOX in
    let lvl_width, lvl_height = dims filename in
    let box = BOX.make P.box_marge P.box_marge lvl_width lvl_height in
    let chan = open_in filename in
    let chars = LoadLevel.char_list_of_channel chan in
    let rec aux x y acc chars =
      match chars with
      | [] -> acc
      | c :: t ->
        (match c with
         | '|' | '-' -> aux x y acc t (* on ignore les bords *)
         | '\n' -> aux box.infx (y -. P.brick_h) acc t
         | '@' -> aux (x +. P.brick_w) y (make_brick x y BRICK.Unbreakable :: acc) t
         | '#' -> aux (x +. P.brick_w) y (make_brick x y BRICK.Strong :: acc) t
         | '=' -> aux (x +. P.brick_w) y (make_brick x y BRICK.Standard :: acc) t
         | '+' -> aux (x +. P.brick_w) y (make_brick x y BRICK.Weak :: acc) t
         | ' ' -> aux (x +. P.brick_w) y acc t
         | _ ->
           failwith
             (Printf.sprintf "Invalid character '%c' in level file '%s'" c filename))
    in
    let bricks = aux 0. box.supy [] chars in
    { bricks; box; filename }
  ;;

  let example_level =
    { bricks =
        [ make_brick 50. 500. BRICK.Strong
        ; make_brick 100. 500. BRICK.Strong
        ; make_brick 150. 500. BRICK.Strong
        ; make_brick 200. 500. BRICK.Strong
        ; make_brick 250. 500. BRICK.Strong
        ; make_brick 300. 500. BRICK.Strong
        ; make_brick 350. 500. BRICK.Strong
        ; make_brick 400. 500. BRICK.Strong
        ; make_brick 450. 500. BRICK.Strong
        ; make_brick 500. 500. BRICK.Strong
        ; make_brick 550. 500. BRICK.Strong
        ; make_brick 600. 500. BRICK.Strong
        ; make_brick 650. 500. BRICK.Strong
        ; make_brick 700. 500. BRICK.Strong
        ; make_brick 50. 470. BRICK.Standard
        ; make_brick 100. 470. BRICK.Standard
        ; make_brick 150. 470. BRICK.Standard
        ; make_brick 200. 470. BRICK.Standard
        ; make_brick 250. 470. BRICK.Standard
        ; make_brick 300. 470. BRICK.Standard
        ; make_brick 350. 470. BRICK.Standard
        ; make_brick 400. 470. BRICK.Standard
        ; make_brick 450. 470. BRICK.Standard
        ; make_brick 500. 470. BRICK.Standard
        ; make_brick 550. 470. BRICK.Standard
        ; make_brick 600. 470. BRICK.Standard
        ; make_brick 650. 470. BRICK.Standard
        ; make_brick 700. 470. BRICK.Standard
        ; make_brick 50. 440. BRICK.Weak
        ; make_brick 100. 440. BRICK.Weak
        ; make_brick 150. 440. BRICK.Weak
        ; make_brick 200. 440. BRICK.Weak
        ; make_brick 250. 440. BRICK.Weak
        ; make_brick 300. 440. BRICK.Weak
        ; make_brick 350. 440. BRICK.Weak
        ; make_brick 400. 440. BRICK.Weak
        ; make_brick 450. 440. BRICK.Weak
        ; make_brick 500. 440. BRICK.Weak
        ; make_brick 550. 440. BRICK.Weak
        ; make_brick 600. 440. BRICK.Weak
        ; make_brick 650. 440. BRICK.Weak
        ; make_brick 700. 440. BRICK.Weak
        ; make_brick 50. 410. BRICK.Weak
        ; make_brick 100. 410. BRICK.Weak
        ; make_brick 150. 410. BRICK.Weak
        ; make_brick 200. 410. BRICK.Weak
        ; make_brick 250. 410. BRICK.Weak
        ; make_brick 300. 410. BRICK.Weak
        ; make_brick 350. 410. BRICK.Weak
        ; make_brick 400. 410. BRICK.Weak
        ; make_brick 450. 410. BRICK.Weak
        ; make_brick 500. 410. BRICK.Weak
        ; make_brick 550. 410. BRICK.Weak
        ; make_brick 600. 410. BRICK.Weak
        ; make_brick 650. 410. BRICK.Weak
        ; make_brick 700. 410. BRICK.Weak
        ]
    ; box = BOX.make 10. 10. 1000. 600.
    ; filename = "example_level"
    }
  ;;
end
