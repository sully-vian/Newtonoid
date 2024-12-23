open Params

module Make (P : PARAMS) = struct
  type t =
    { marge : float
    ; infx : float
    ; infy : float
    ; supx : float
    ; supy : float
    }

  let make =
    { marge = P.box_marge
    ; infx = P.box_infx
    ; infy = P.box_infy
    ; supx = P.box_supx
    ; supy = P.box_supy
    }
  ;;

  let draw box =
    Graphics.(
      set_color black;
      draw_rect
        (int_of_float box.infx)
        (int_of_float box.infy)
        (int_of_float (box.supx -. box.infx))
        (int_of_float (box.supy -. box.infy)))
  ;;
end
