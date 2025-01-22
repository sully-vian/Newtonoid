open Iterator
open Params

module Make (P : PARAMS) = struct
  module BALL = Ball.Make (P)
  module PADDLE = Paddle.Make (P)
  module LEVEL = Level.Make (P)
  module COLLISION = Collision.Make (P)

  type game_status =
    | Init
    | Playing
    | GameOver
    | Victory

  type t =
    { ball : BALL.t
    ; level : LEVEL.t
    ; score : int
    ; paddle : PADDLE.t
    ; status : game_status
    }

  let make level =
    { ball = BALL.make; level; score = 0; paddle = PADDLE.make; status = Init }
  ;;

  let update (x_mouse, click) { ball; level; score; paddle; status } =
    match status with
    | Init ->
      let paddle' = PADDLE.update x_mouse paddle in
      let ball' =
        let x' = PADDLE.(paddle'.x +. (paddle'.w /. 2.)) in
        let y' = PADDLE.(paddle'.y +. paddle'.h) +. BALL.(ball.r) in
        BALL.{ ball with x = x'; y = y'; vx = 0.; vy = P.ball_init_vy }
      in
      let status' =
        (* début du jeu si click *)
        if click then
          Playing
        else
          Init
      in
      { ball = ball'; level; score; paddle = paddle'; status = status' }
    | Playing ->
      (* m-à-j de la raquette puis collisions et test de survie *)
      let paddle' = PADDLE.update x_mouse paddle in
      let ball', level', score' =
        let after_update = BALL.move ball in
        COLLISION.(
          let after_paddle = with_paddle after_update paddle in
          let after_box = with_box after_paddle in
          let after_level = with_level after_box level score in
          after_level)
      in
      let status' =
        if BALL.(ball.pv == ball'.pv) then
          Playing
        else
          (* si une vie est perdue, on replace la balle sur la raquette *)
          Init
      in
      { ball = ball'; level = level'; score = score'; paddle = paddle'; status = status' }
    | _ ->
      (* on ne met pas à jour l'état lorsque le jeu est fini *)
      { ball; level; score; paddle; status }
  ;;

  let is_alive { ball; _ } = BALL.(ball.pv) > 0

  (** [unfold f flux e] est une sorte de [Flux.unfold] où [f] prend un second argument issu de [flux]. On l'utilise ici pour créer le flux d'états qui doit être généré avec les méthodes de mise-à-jour ET avec le flux de la souris. Son utilisation est moins abstraite si on explicite son type comme tel: [('mouse -> 'state -> 'state option) -> 'mouse Flux.t -> 'state -> 'state Flux.t] *)
  let rec unfold2 f flux e =
    Tick
      (lazy
        (match Flux.uncons flux with
         | None -> None
         | Some (flux_h, flux_t) ->
           (match f flux_h e with
            | None -> None
            | Some e' -> Some (e, unfold2 f flux_t e'))))
  ;;

  let make_flux mouse_flux initial_state =
    let f mouse state =
      if not (is_alive state) then
        Some (update mouse { state with status = GameOver })
      else if LEVEL.is_finished state.level then
        Some (update mouse { state with status = Victory })
      else
        Some (update mouse state)
    in
    unfold2 f mouse_flux initial_state
  ;;

  let draw_score score =
    Graphics.(
      set_color P.text_color;
      moveto 15 30;
      draw_string (Format.sprintf "Score : %d" score))
  ;;

  let draw_pv ball =
    Graphics.(
      set_color P.text_color;
      moveto 15 15;
      draw_string (Format.sprintf "PVs : %d" BALL.(ball.pv)))
  ;;

  (* TODO: changer la taille du texte *)
  let draw_game_over score =
    Graphics.(
      let line1 = "Game Over !" in
      let line2 = Format.sprintf "Final Score: %d" score in
      let line1_w, _ = text_size line1 in
      let line2_w, _ = text_size line2 in
      let middle_x = int_of_float (P.box_supx -. P.box_infx) / 2 in
      let middle_y = int_of_float (P.box_supy -. P.box_infy) / 2 in
      set_color red;
      moveto (middle_x - (line1_w / 2)) (middle_y + 10);
      draw_string line1;
      moveto (middle_x - (line2_w / 2)) (middle_y - 10);
      draw_string line2)
  ;;

  (* TODO: changer la taille du texte *)
  let draw_victory score =
    Graphics.(
      let line1 = "Victory !" in
      let line2 = Format.sprintf "Final Score: %d" score in
      let line1_w, _ = text_size line1 in
      let line2_w, _ = text_size line2 in
      let middle_x = int_of_float (P.box_supx -. P.box_infx) / 2 in
      let middle_y = int_of_float (P.box_supy -. P.box_infy) / 2 in
      set_color green;
      moveto (middle_x - (line1_w / 2)) (middle_y + 10);
      draw_string line1;
      moveto (middle_x - (line2_w / 2)) (middle_y - 10);
      draw_string line2)
  ;;

  let draw { ball; level; score; paddle; status } =
    LEVEL.draw_shadow level;
    PADDLE.draw_shadow paddle;
    BALL.draw_shadow ball;
    LEVEL.draw level;
    PADDLE.draw paddle;
    BALL.draw ball;
    draw_score score;
    draw_pv ball;
    if status = GameOver then
      draw_game_over score
    else if status = Victory then
      draw_victory score;
    (* Debug *)
    Graphics.(
      set_color P.text_color;
      moveto 100 15;
      draw_string (Format.sprintf "ball x: %d" (int_of_float BALL.(ball.x)));
      moveto 100 30;
      draw_string (Format.sprintf "ball y: %d" (int_of_float BALL.(ball.y)));
      moveto 175 15;
      draw_string (Format.sprintf "ball vx: %d" (int_of_float BALL.(ball.vx)));
      moveto 175 30;
      draw_string (Format.sprintf "ball vy: %d" (int_of_float BALL.(ball.vy))))
  ;;
end
