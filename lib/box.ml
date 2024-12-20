open Params

type t =
  { marge : float
  ; infx : float
  ; infy : float
  ; supx : float
  ; supy : float
  }

module Make (P : PARAMS) = struct
  let make marge infx infy supx supy = { marge; infx; infy; supx; supy }

  let draw box =
    Graphics.set_color Graphics.black;
    Graphics.draw_rect
      (int_of_float box.infx)
      (int_of_float box.infy)
      (int_of_float (box.supx -. box.infx))
      (int_of_float (box.supy -. box.infy))
  ;;
end
