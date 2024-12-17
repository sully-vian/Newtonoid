(* ouvre la bibliotheque de modules definis dans lib/ *)
open Libnewtonoid
open Iterator

module Init = struct
  let dt = 1. /. 60. (* 60 Hz *)
end

let box = Box.make 10. 10. 10. 150. 100. (* format de la fenêtre graphique *)

let graphic_format =
  Format.sprintf
    " %dx%d+50+50"
    (int_of_float ((2. *. box.marge) +. box.supx -. box.infx))
    (int_of_float ((2. *. box.marge) +. box.supy -. box.infy))
;;

(* TODO *)
let draw_state etat = failwith "A DEFINIR"

(* TODO: extrait le score courant d'un etat : *)
let score etat : int = failwith "A DEFINIR"

let draw flux_etat =
  let rec loop flux_etat last_score =
    match Flux.(uncons flux_etat) with
    | None -> last_score
    | Some (etat, flux_etat') ->
      Graphics.clear_graph ();
      (* DESSIN ETAT *)
      draw_state etat;
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
let follow_mouse () =
  let rec loop current_paddle flux_mouse =
    Graphics.clear_graph ();
    match Flux.(uncons flux_mouse) with
    | None -> ()
    | Some ((mouse_x, _), flux_mouse') ->
      let paddle' = Paddle.update current_paddle mouse_x in
      Paddle.draw paddle';
      Graphics.synchronize ();
      Unix.sleepf Init.dt;
      loop paddle' flux_mouse'
  in
  Graphics.open_graph graphic_format;
  Graphics.auto_synchronize false;
  let paddle = Paddle.make 50. 50. 100. 20. in
  loop paddle Input.mouse
;;

(* exemple de dessin de niveau *)
let draw_level () =
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

(* exemple de balle qui rebondit *)
let draw_ball () =
  Graphics.open_graph graphic_format;
  Graphics.auto_synchronize false;
  let rec loop ball =
    Graphics.clear_graph ();
    Ball.draw ball;
    Graphics.synchronize ();
    Unix.sleepf Init.dt;
    let ball' = Collision.ball_box (Ball.update ball Init.dt) box in
    loop ball'
  in
  let ball = Ball.make 400. 300. 10. 100. 200. in
  loop ball
;;

let () = draw_ball ()
