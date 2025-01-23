(* ouvre la bibliotheque de modules definis dans lib/ *)
open Libnewtonoid
open Iterator

let usage () =
  Printf.printf "Usage: %s [config_file] [level_files...]\n" Sys.argv.(0);
  Printf.printf "  config_file: path to config file\n";
  Printf.printf "  level_files: paths to level files\n";
  exit 1
;;

let load_levels level_files =
  Array.to_list (Array.sub level_files 2 (Array.length level_files - 2))
;;

let main_flux () =
  if Array.length Sys.argv < 3 then usage ();
  (* instanciation des modules *)
  let module P =
    Params.Make (struct
      let config_filename = Sys.argv.(1)
      let level_filename = Sys.argv.(2) (* L'emplacement du fichier va évoluer *)
    end)
  in
  let module PV = ParamValidator.Make (P) in
  PV.run_tests ();
  let module STATE = State.Make (P) in
  let module BOX = Box.Make (P) in
  let module LEVEL = Level.Make (P) in
  let box = BOX.make in
  (* format de la fenêtre graphique *)
  let graphic_format =
    let open BOX in
    Format.sprintf
      " %dx%d+50+50"
      (int_of_float ((2. *. box.marge) +. box.supx -. box.infx))
      (int_of_float ((2. *. box.marge) +. box.supy -. box.infy))
  in
  let level_files = load_levels Sys.argv in
  let levels = List.map LEVEL.load_level level_files in
  let initial_state = STATE.make (List.hd levels) 0 in
  let initial_state = { initial_state with levels; current_level_index = 0 } in
  let rec loop state_flux =
    match Flux.uncons state_flux with
    | None -> ()
    | Some (state, state_flux') ->
      Graphics.clear_graph ();
      (* dessiner le background *)
      Graphics.set_color P.bg_color;
      Graphics.fill_rect 0 0 (Graphics.size_x ()) (Graphics.size_y ());
      STATE.draw state;
      BOX.draw box;
      Graphics.synchronize ();
      Unix.sleepf P.dt;
      loop state_flux'
  in
  Graphics.(
    set_window_title "Newtonoid";
    open_graph graphic_format;
    auto_synchronize false);
  loop (STATE.make_flux Input.mouse initial_state);
  Graphics.close_graph ()
;;

let () = main_flux ()
