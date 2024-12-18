(* ouvre la bibliotheque de modules definis dans lib/ *)
open Libnewtonoid
open Iterator

module Init = struct
  let dt = 1. /. 60. (* 60 Hz *)
end

let box = Box.make 10. 10. 10. 800. 600. (* format de la fenêtre graphique *)

let graphic_format =
  Format.sprintf
    " %dx%d+50+50"
    (int_of_float ((2. *. box.marge) +. box.supx -. box.infx))
    (int_of_float ((2. *. box.marge) +. box.supy -. box.infy))
;;

(* TODO *)
let draw_state etat = failwith "A DEFINIR"

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
  in
  Graphics.set_window_title "Newtonoid";
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
  Graphics.set_window_title "Newtonoid";
  Graphics.open_graph graphic_format;
  Graphics.auto_synchronize false;
  let paddle = Paddle.make 50. 50. 100. 20. in
  loop paddle Input.mouse
;;

(* exemple de dessin de niveau *)
let draw_level () =
  Graphics.set_window_title "Newtonoid";
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
  Graphics.set_window_title "Newtonoid";
  Graphics.open_graph graphic_format;
  Graphics.auto_synchronize false;
  let rec loop ball =
    Graphics.clear_graph ();
    Ball.draw ball;
    Graphics.synchronize ();
    Unix.sleepf Init.dt;
    let ball' = Collision.with_box (Ball.update ball Init.dt) box in
    loop ball'
  in
  let ball = Ball.make 400. 300. 10. 100. 200. in
  loop ball
;;

(* exemple de balle avec une brique *)
let collide_brick () =
  Graphics.set_window_title "Newtonoid";
  Graphics.open_graph graphic_format;
  Graphics.auto_synchronize false;
  let rec loop ball brick =
    Graphics.clear_graph ();
    Brick.draw brick;
    Ball.draw ball;
    Graphics.synchronize ();
    Unix.sleepf Init.dt;
    let ball', brick' =
      Collision.with_brick (Collision.with_box (Ball.update ball Init.dt) box) brick
    in
    loop ball' brick'
  in
  let ball = Ball.make 400. 300. 10. 300. 500. in
  let brick = Brick.make (Rectangle.make 100. 100. 600. 50.) Brick.Strong in
  loop ball brick
;;

(* exemple de balle avec plusieurs briques *)
(* let collide_level () = Graphics.set_window_title "Newtonoid"; Graphics.open_graph
   graphic_format; Graphics.auto_synchronize false; let rec loop ball level =
   Graphics.clear_graph (); Level.draw level; Ball.draw ball; Graphics.synchronize ();
   Unix.sleepf Init.dt; let ball', level' = Collision.ball_level (Collision.ball_box
   (Ball.update ball Init.dt) box) level in loop ball' level' in let ball = Ball.make 400.
   300. 10. 300. 500. in let level = Level.example_level in loop ball level ;; *)

(* exemple avec le score en plus *)
let collide_score () =
  Graphics.set_window_title "Newtonoid";
  Graphics.open_graph graphic_format;
  Graphics.auto_synchronize false;
  let update = State.update box Init.dt in
  let rec loop state =
    Graphics.clear_graph ();
    State.draw state;
    Graphics.synchronize ();
    Unix.sleepf Init.dt;
    let state' = update state in
    loop state'
  in
  let ball = Ball.make 400. 200. 10. 300. 500. in
  let level = Level.example_level in
  loop (ball, level, 0)
;;

(* exemple avec la raquette en plus *)
let main_paddle () =
  let update = State.update2 box Init.dt in
  let rec loop state paddle_flux =
    match Flux.uncons paddle_flux with
    | None -> ()
    | Some (paddle, paddle_flux') ->
      Graphics.clear_graph ();
      Box.draw box;
      State.draw2 paddle state;
      Graphics.synchronize ();
      Unix.sleepf Init.dt;
      let state' = update paddle state in
      if State.is_alive state then
        loop state' paddle_flux'
      else
        ()
  in
  Graphics.set_window_title "Newtonoid";
  Graphics.open_graph graphic_format;
  Graphics.auto_synchronize false;
  let ball = Ball.make 400. 200. 10. 300. 500. in
  let level = Level.example_level in
  let paddle = Paddle.make 20. 50. 100. 20. in
  loop (ball, level, 0) (Paddle.make_flux box paddle)
;;

let () = main_paddle ()
