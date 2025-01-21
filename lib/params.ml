module type PARAMS = sig
  val ball_r : float
  val ball_pv : int
  val ball_init_vy : float
  val ball_max_vx : float
  val ball_max_vy : float
  val ball_bounce_factor : float
  val box_marge : float
  val box_infx : float
  val box_infy : float
  val box_supx : float
  val box_supy : float
  val brick_weak_pv : int
  val brick_standard_pv : int
  val brick_strong_pv : int
  val brick_weak_xp : int
  val brick_standard_xp : int
  val brick_strong_xp : int
  val brick_w : float
  val brick_h : float
  val paddle_x : float
  val paddle_y : float
  val paddle_w : float
  val paddle_h : float
  val dt : float
  val ball_color : Graphics.color
  val paddle_color : Graphics.color
  val brick_weak_color : Graphics.color
  val brick_standard_color : Graphics.color
  val brick_strong_color : Graphics.color
  val brick_unbreakable_color : Graphics.color
  val shadow_color : Graphics.color
end

module Make (ConfigFile : sig
  val filename : string
end) : PARAMS = struct
  (* liste associant les clés aux valeurs *)
  let config =
    let chan = open_in ConfigFile.filename in
    let key_value_pairs = Utils.parse_key_value_pairs chan in
    key_value_pairs
  ;;

  (* méthodes de parsing *)
  let assoc_int key = Utils.assoc_int config key
  let assoc_float key = Utils.assoc_float config key
  let assoc_color key = Utils.assoc_color config key

  (* asssignation des paramètres *)
  let ball_r = assoc_float "ball_r"
  let ball_pv = assoc_int "ball_pv"
  let ball_init_vy = assoc_float "ball_init_vy"
  let ball_max_vx = assoc_float "ball_max_vx"
  let ball_max_vy = assoc_float "ball_max_vy"
  let ball_bounce_factor = assoc_float "ball_bounce_factor"
  let box_marge = assoc_float "box_marge"
  let box_infx = assoc_float "box_infx"
  let box_infy = assoc_float "box_infy"
  let box_supx = assoc_float "box_supx"
  let box_supy = assoc_float "box_supy"
  let brick_weak_pv = assoc_int "brick_weak_pv"
  let brick_standard_pv = assoc_int "brick_standard_pv"
  let brick_strong_pv = assoc_int "brick_strong_pv"
  let brick_weak_xp = assoc_int "brick_weak_xp"
  let brick_standard_xp = assoc_int "brick_standard_xp"
  let brick_strong_xp = assoc_int "brick_strong_xp"
  let brick_w = assoc_float "brick_w"
  let brick_h = assoc_float "brick_h"
  let paddle_x = assoc_float "paddle_x"
  let paddle_y = assoc_float "paddle_y"
  let paddle_w = assoc_float "paddle_w"
  let paddle_h = assoc_float "paddle_h"
  let dt = assoc_float "dt"
  let ball_color = assoc_color "ball_color"
  let paddle_color = assoc_color "paddle_color"
  let brick_weak_color = assoc_color "brick_weak_color"
  let brick_standard_color = assoc_color "brick_standard_color"
  let brick_strong_color = assoc_color "brick_strong_color"
  let brick_unbreakable_color = assoc_color "brick_unbreakable_color"
  let shadow_color = assoc_color "shadow_color"
end
