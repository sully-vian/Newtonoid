open Params

type t =
  { x : float
  ; y : float
  ; w : float
  ; h : float
  }

module Make (P : PARAMS) = struct
  let make x y w h = { x; y; w; h }

  let draw rect =
    Graphics.fill_rect
      (int_of_float rect.x)
      (int_of_float rect.y)
      (int_of_float rect.w)
      (int_of_float rect.h)
  ;;
end
