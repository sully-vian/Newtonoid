(* ouvre la bibliotheque de modules definis dans lib/ *)
open Libnewtonoid
open Iterator
module STATE = State.Make (Params.Default)
module BALL = Ball.Make (Params.Default)
module BOX = Box.Make (Params.Default)
module LEVEL = Level.Make (Params.Default)
module PADDLE = Paddle.Make (Params.Default)

module Init = struct
  let dt = 1. /. 60. (* 60 Hz *)
end

let box = BOX.make 10. 10. 10. 800. 600. (* format de la fenêtre graphique *)

let graphic_format =
  let open Box in
  Format.sprintf
    " %dx%d+50+50"
    (int_of_float ((2. *. box.marge) +. box.supx -. box.infx))
    (int_of_float ((2. *. box.marge) +. box.supy -. box.infy))
;;

(* TODO *)
let draw_state _etat = failwith "A DEFINIR"

let draw flux_etat =
  let rec loop flux_etat last_score =
    match Flux.(uncons flux_etat) with
    | None -> last_score
    | Some (etat, flux_etat') ->
      Graphics.clear_graph ();
      (* DESSIN ETAT *)
      ignore (draw_state etat);
      (* FIN DESSIN ETAT *)
      Graphics.synchronize ();
      Unix.sleepf Init.dt;
      (* loop flux_etat' (last_score + score etat) *)
      loop flux_etat' last_score
  in
  Graphics.set_window_title "Newtonoid";
  Graphics.open_graph graphic_format;
  Graphics.auto_synchronize false;
  let score = loop flux_etat 0 in
  Format.printf "Score final : %d@\n" score;
  Graphics.close_graph ()
;;

let main_flux () =
  let rec loop state_flux =
    match Flux.uncons state_flux with
    | None -> ()
    | Some (state, state_flux') ->
      Graphics.clear_graph ();
      BOX.draw box;
      STATE.draw state;
      Graphics.synchronize ();
      Unix.sleepf Init.dt;
      loop state_flux'
  in
  Graphics.(
    set_window_title "Newtonoid";
    open_graph graphic_format;
    auto_synchronize false);
  let level = LEVEL.example_level in
  let paddle = PADDLE.make 20. 50. 100. 20. 0. in
  let score = 0 in
  let ball =
    BALL.make Box.(box.infx +. (box.supx /. 2.)) Paddle.(paddle.y +. paddle.h +. 10.) 10.
  in
  let initial_state = State.{ ball; level; score; paddle } in
  loop (STATE.make_flux box Init.dt Input.mouse initial_state)
;;

let () = main_flux ()
