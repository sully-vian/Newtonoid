open Params

module Make (P : PARAMS) = struct
  type t =
    { marge : float
    ; infx : float
    ; infy : float
    ; supx : float
    ; supy : float
    }

  let make infx infy supx supy = { marge = P.box_marge; infx; infy; supx; supy }

  let resize_window box =
    let win_w = int_of_float (box.supx +. box.marge) in
    let win_h = int_of_float (box.supy +. box.marge) in
    Graphics.resize_window win_w win_h
  ;;

  let middle box =
    ( int_of_float ((box.supx -. box.infx) /. 2.)
    , int_of_float ((box.supy -. box.infy) /. 2.) )
  ;;

  let draw box =
    Graphics.(
      set_color P.borders_color;
      draw_rect
        (int_of_float box.infx)
        (int_of_float box.infy)
        (int_of_float (box.supx -. box.infx))
        (int_of_float (box.supy -. box.infy)))
  ;;
end
