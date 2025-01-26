open Iterator
open Params

module Make (P : PARAMS) = struct
  module BALL = Ball.Make (P)
  module PADDLE = Paddle.Make (P)
  module LEVEL = Level.Make (P)
  module COLLISION = Collision.Make (P)
  module BOX = Box.Make (P)

  type game_status =
    | Init
    | Playing
    | GameOver
    | Victory
    | Paused
    | SwitchLevel
    | Quit

  type t =
    { ball : BALL.t
    ; level : LEVEL.t
    ; score : int
    ; paddle : PADDLE.t
    ; status : game_status
    }

  let make level previous_score =
    { ball = BALL.make
    ; level
    ; score = previous_score
    ; paddle = PADDLE.make
    ; status = Init
    }
  ;;

  let update (x_mouse, click) state =
    if click then
      (* dodo pour éviter de comptabiliser plusieurs clicks en une frame *)
      Unix.sleepf 0.1;
    match state.status with
    | Paused ->
      let status' =
        if click then
          Playing
        else
          Paused
      in
      { state with status = status' }
    | GameOver ->
      let status' =
        if click then
          Quit
        else
          GameOver
      in
      { state with status = status' }
    | Victory ->
      let status' =
        if click then
          SwitchLevel
        else
          Victory
      in
      { state with status = status' }
    | Init ->
      let paddle' = PADDLE.update LEVEL.(state.level.box) x_mouse state.paddle in
      let ball' =
        let x' = PADDLE.(paddle'.x +. (paddle'.w /. 2.)) in
        let y' = PADDLE.(paddle'.y +. paddle'.h) +. BALL.(state.ball.r) in
        BALL.{ state.ball with x = x'; y = y'; vx = 0.; vy = P.ball_init_vy }
      in
      let status' =
        (* début du jeu si click *)
        if click then
          Playing
        else
          Init
      in
      { state with ball = ball'; paddle = paddle'; status = status' }
    | Playing ->
      (* m-à-j de la raquette puis collisions et test de survie *)
      let paddle' = PADDLE.update LEVEL.(state.level.box) x_mouse state.paddle in
      let ball', level', score' =
        let after_update = BALL.move state.ball in
        COLLISION.(
          let after_paddle = with_paddle after_update state.paddle in
          let after_box = with_box LEVEL.(state.level.box) after_paddle in
          let after_level = with_level after_box state.level state.score in
          after_level)
      in
      let status' =
        if BALL.(ball'.pv) = 0 then
          (* partie perdue *)
          GameOver
        else if BALL.(state.ball.pv > ball'.pv) then
          (* vie perdue on replace la balle sur la raquette *)
          Init
        else if click then
          (* jeu mis en pause *)
          Paused
        else if LEVEL.is_finished level' then
          (* niveau terminé *)
          Victory
        else
          Playing
      in
      { ball = ball'; level = level'; score = score'; paddle = paddle'; status = status' }
    | SwitchLevel ->
      (* ne devrait pas arriver *)
      print_endline "SwitchLevel";
      exit 1
    | Quit ->
      (* ne devrait pas arriver *)
      print_endline "Quit";
      exit 1
  ;;

  let is_alive { ball; _ } = BALL.(ball.pv) > 0

  let make_flux mouse_flux (initial_state, next_levels) =
    let f mouse (state, next_levels) =
      if state.status = SwitchLevel then (
        match next_levels with
        | [] -> None
        | next_level :: next_levels_t ->
          let box = LEVEL.(next_level.box) in
          BOX.resize_window box;
          Some
            (update mouse { state with level = next_level; status = Init }, next_levels_t)
      ) else if state.status = Quit then
        None
      else
        Some (update mouse state, next_levels)
    in
    Flux.map fst (Utils.unfold2 f mouse_flux (initial_state, next_levels))
  ;;

  let draw_score score =
    Graphics.(
      set_font P.medium_font;
      set_color P.text_color;
      moveto 15 30;
      draw_string (Format.sprintf "Score : %d" score))
  ;;

  let draw_pv ball =
    Graphics.(
      set_font P.medium_font;
      set_color P.text_color;
      moveto 15 15;
      draw_string (Format.sprintf "PVs : %d" BALL.(ball.pv)))
  ;;

  let draw_pause state =
    let line1 = "Paused" in
    let line2 = "Click to resume" in
    Graphics.(
      set_font P.large_font;
      let line1_w, _ = text_size line1 in
      let middle_x, middle_y = BOX.middle LEVEL.(state.level.box) in
      set_color P.text_color;
      moveto (middle_x - (line1_w / 2)) (middle_y + 10);
      draw_string line1;
      set_font P.medium_font;
      let line2_w, _ = text_size line2 in
      moveto (middle_x - (line2_w / 2)) (middle_y - 10);
      draw_string line2)
  ;;

  let draw_game_over state =
    let line1 = "Game Over !" in
    let line2 = Format.sprintf "Final Score: %d" state.score in
    let line3 = "Click to quit game" in
    Graphics.(
      set_font P.large_font;
      let line1_w, _ = text_size line1 in
      let line2_w, _ = text_size line2 in
      let middle_x, middle_y = BOX.middle LEVEL.(state.level.box) in
      set_color red;
      moveto (middle_x - (line1_w / 2)) (middle_y + 10);
      draw_string line1;
      moveto (middle_x - (line2_w / 2)) (middle_y - 10);
      draw_string line2;
      (* quit game *)
      set_font P.medium_font;
      let line3_w, _ = text_size line3 in
      set_color P.text_color;
      moveto (middle_x - (line3_w / 2)) (middle_y - 30);
      draw_string line3)
  ;;

  let draw_init state =
    let line1 = "Click to throw ball" in
    let line2 = "Use mouse to move paddle" in
    let line3 = "Click to pause" in
    Graphics.(
      set_font P.medium_font;
      let line1_w, _ = text_size line1 in
      let line2_w, _ = text_size line2 in
      let line3_w, _ = text_size line3 in
      let middle_x, middle_y = BOX.middle LEVEL.(state.level.box) in
      set_color P.text_color;
      moveto (middle_x - (line1_w / 2)) (middle_y + 10);
      draw_string line1;
      moveto (middle_x - (line2_w / 2)) (middle_y - 10);
      draw_string line2;
      moveto (middle_x - (line3_w / 2)) (middle_y - 30);
      draw_string line3)
  ;;

  let draw_victory state =
    let line1 = "Victory !" in
    let line2 = Format.sprintf "Score: %d" state.score in
    let line3 = "Click to go to the next level (or quit if it's the last one)" in
    Graphics.(
      (* victory message *)
      set_font P.large_font;
      let line1_w, _ = text_size line1 in
      let line2_w, _ = text_size line2 in
      let middle_x, middle_y = BOX.middle LEVEL.(state.level.box) in
      set_color green;
      moveto (middle_x - (line1_w / 2)) (middle_y + 10);
      draw_string line1;
      moveto (middle_x - (line2_w / 2)) (middle_y - 10);
      draw_string line2;
      (* goto next level *)
      set_font P.medium_font;
      let line3_w, _ = text_size line3 in
      set_color P.text_color;
      moveto (middle_x - (line3_w / 2)) (middle_y - 30);
      draw_string line3)
  ;;

  let draw state =
    LEVEL.draw_shadow state.level;
    PADDLE.draw_shadow state.paddle;
    BALL.draw_shadow state.ball;
    LEVEL.draw state.level;
    PADDLE.draw state.paddle;
    BALL.draw state.ball;
    draw_score state.score;
    draw_pv state.ball;
    (* dessiner spécifiquement l'état *)
    (match state.status with
     | Init -> draw_init
     | GameOver -> draw_game_over
     | Victory -> draw_victory
     | Paused -> draw_pause
     | _ -> fun _ -> ())
      state;
    (* Debug *)
    Graphics.(
      let ball = state.ball in
      set_font P.medium_font;
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
