(* ouvre la bibliotheque de modules definis dans lib/ *)
open Libnewtonoid
open Iterator

(* exemple d'ouvertue d'un tel module de la bibliotheque : *)
open Game

module Init = struct
  let dt = 1. /. 60. (* 60 Hz *)
end

module Box = struct
  let marge = 10.
  let infx = 10.
  let infy = 10.
  let supx = 790.
  let supy = 590.
end

let graphic_format =
  Format.sprintf
    " %dx%d+50+50"
    (int_of_float ((2. *. Box.marge) +. Box.supx -. Box.infx))
    (int_of_float ((2. *. Box.marge) +. Box.supy -. Box.infy))
;;

(* TODO *)
let draw_state etat = failwith "A DEFINIR"

(* TODO: extrait le score courant d'un etat : *)
let score etat : int = failwith "A DEFINIR"

let draw flux_etat =
  let rec loop flux_etat last_score =
    match Flux.(uncons flux_etat) with
    | None -> last_score
    | Some ((x, _), flux_etat') ->
      Graphics.clear_graph ();
      (* DESSIN ETAT *)
      (* draw_state etat; *)
      Rectangle.draw (Rectangle.make x 10. 50. 20.);
      (* FIN DESSIN ETAT *)
      Graphics.synchronize ();
      Unix.sleepf Init.dt;
      (* loop flux_etat' (last_score + score etat) *)
      loop flux_etat' last_score
    | _ -> assert false
  in
  Graphics.open_graph graphic_format;
  Graphics.auto_synchronize false;
  let score = loop flux_etat 0 in
  Format.printf "Score final : %d@\n" score;
  Graphics.close_graph ()
;;

(* exemple de rectangle qui suit la souris *)
let follow_mouse () = draw Input.mouse

(* exemple de dessin de niveau *)
let level_draw () =
  Graphics.open_graph graphic_format;
  Graphics.auto_synchronize false;
  let rec loop () =
    Graphics.clear_graph ();
    Level.draw Level.example_level;
    Graphics.synchronize ();
    Unix.sleepf Init.dt;
    loop ()
  in
  loop ()
;;

let () = game_hello ()
