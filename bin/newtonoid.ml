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
  let module PFile =
    Params.Make (struct
      let config_filename = Sys.argv.(1)
      let level_filename = Sys.argv.(2) (* L'emplacement du fichier va évoluer *)
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
  in
  let level_files = load_levels Sys.argv in
  let rec loop levels current_score =
    match levels with
    | [] -> current_score
    | level_file :: rest ->
      let level = LEVEL.load_level level_file in
      let initial_state = STATE.make level in
      let rec play_level state_flux =
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
          if LEVEL.is_finished state.level then
            loop rest (current_score + STATE.(state.score))
          else
            play_level state_flux'
      in
      play_level (STATE.make_flux Input.mouse initial_state)
  in
  Graphics.(
    set_window_title "Newtonoid";
    open_graph graphic_format;
    auto_synchronize false);
  let final_score = loop level_files 0 in
  Format.printf "Final Score : %d@\n" final_score;
  Graphics.close_graph ()
;;

let () = main_flux ()
