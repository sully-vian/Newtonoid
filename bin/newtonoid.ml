(* ouvre la bibliotheque de modules definis dans lib/ *)
open Libnewtonoid
open Iterator

let usage () =
  Printf.printf "Usage: %s [level_file] [config_file]\n" Sys.argv.(0);
  Printf.printf "  level_file: path to level file\n";
  Printf.printf "  config_file: path to config file\n";
  exit 1
;;

let main_flux () =
  if Array.length Sys.argv <> 3 then usage ();
  (* instanciation des modules *)
  let module PFile =
    Params.Make (struct
      let config_filename = Sys.argv.(2)
      let level_filename = Sys.argv.(1)
    end)
  in
  let module T = Tests.Make (PFile) in
  T.run_tests ();
  let module STATE = State.Make (PFile) in
  let module BOX = Box.Make (PFile) in
  let module LEVEL = Level.Make (PFile) in
  let box = BOX.make in
  (* format de la fenêtre graphique *)
  let graphic_format =
    let open BOX in
    Format.sprintf
      " %dx%d+50+50"
      (int_of_float ((2. *. box.marge) +. box.supx -. box.infx))
      (int_of_float ((2. *. box.marge) +. box.supy -. box.infy))
  and level = LEVEL.load_level Sys.argv.(1) in
  let initial_state = STATE.make level in
  let rec loop state_flux current_score =
    match Flux.uncons state_flux with
    | None -> current_score
    | Some (state, state_flux') ->
      Graphics.clear_graph ();
      (* draw background *)
      Graphics.set_color PFile.bg_color;
      Graphics.fill_rect 0 0 (Graphics.size_x ()) (Graphics.size_y ());
      STATE.draw state;
      BOX.draw box;
      Graphics.synchronize ();
      Unix.sleepf PFile.dt;
      loop state_flux' STATE.(state.score)
  in
  Graphics.(
    set_window_title "Newtonoid";
    open_graph graphic_format;
    auto_synchronize false);
  let final_score = loop (STATE.make_flux Input.mouse initial_state) 0 in
  Format.printf "Final Score : %d@\n" final_score;
  Graphics.close_graph ()
;;

let () = main_flux ()
