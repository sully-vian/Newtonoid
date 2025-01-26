(* ouvre la bibliotheque de modules definis dans lib/ *)
open Libnewtonoid
open Iterator

let usage () =
  Printf.printf "Usage: %s [config_file] [level_files...]\n" Sys.argv.(0);
  Printf.printf "  config_file: path to config file\n";
  Printf.printf
    "  level_files: optional paths to level files (you can specify multiple files)\n";
  exit 1
;;

let default_levels = [ "levels/default-1.txt"; "levels/default-2.txt" ]
let default_config = "configs/default.conf"

let parse_args args =
  match Array.length args with
  | 1 -> default_config, default_levels
  | n when n > 2 -> args.(1), Array.to_list (Array.sub args 2 (n - 2))
  | _ -> usage ()
;;

let main () =
  let config_file, level_files = parse_args Sys.argv in
  (* instanciation des modules *)
  let module P =
    Params.Make (struct
      let config_filename = config_file
    end)
  in
  let module PV = ParamValidator.Make (P) in
  PV.run_tests ();
  let module STATE = State.Make (P) in
  let module BOX = Box.Make (P) in
  let module LEVEL = Level.Make (P) in
  let levels = List.map LEVEL.load level_files in
  let first_level = List.hd levels in
  let lvl_width, lvl_height = LEVEL.dims (List.hd level_files) in
  let box = BOX.make P.box_marge P.box_marge lvl_width lvl_height in
  (* format de la fenêtre graphique *)
  let graphic_format =
    let open BOX in
    Format.sprintf
      " %dx%d+50+50"
      (int_of_float ((2. *. box.marge) +. box.supx -. box.infx))
      (int_of_float ((2. *. box.marge) +. box.supy -. box.infy))
  in
  let initial_state = STATE.make first_level 0 in
  let state_flux = STATE.make_flux Input.mouse (initial_state, List.tl levels) in
  let rec loop state_flux current_score =
    match Flux.uncons state_flux with
    | None -> current_score
    | Some (state, state_flux') ->
      Graphics.clear_graph ();
      (* dessiner le background *)
      Graphics.set_color P.bg_color;
      Graphics.fill_rect 0 0 (Graphics.size_x ()) (Graphics.size_y ());
      STATE.draw state;
      Graphics.synchronize ();
      Unix.sleepf P.dt;
      loop state_flux' STATE.(state.score)
  in
  Graphics.(
    set_window_title "Newtonoid";
    open_graph graphic_format;
    auto_synchronize false);
  BOX.resize_window LEVEL.(first_level.box);
  let final_score = loop state_flux 0 in
  Format.printf "Final Score : %d@\n" final_score;
  Graphics.close_graph ()
;;

let () = main ()
