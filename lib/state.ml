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

  let update (x_mouse, click) { ball; level; score; paddle; status } =
    if click then
      (* dodo pour éviter de comptabiliser plusieurs clicks en une frame *)
      Unix.sleepf 0.1;
    match status with
    | Paused ->
      let status' =
        if click then
          Playing
        else
          Paused
      in
      { ball; level; score; paddle; status = status' }
    | Init ->
      let paddle' = PADDLE.update LEVEL.(level.box) x_mouse paddle in
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
      let paddle' = PADDLE.update LEVEL.(level.box) x_mouse paddle in
      let ball', level', score' =
        let after_update = BALL.move ball in
        COLLISION.(
          let after_paddle = with_paddle after_update paddle in
          let after_box = with_box LEVEL.(level.box) after_paddle in
          let after_level = with_level after_box level score in
          after_level)
      in
      let status' =
        if BALL.(ball.pv > ball'.pv) then
          (* vie perdue *)
          Init
        else if click then
          (* jeu mis en pause *)
          Paused
        else if LEVEL.is_finished level' then
          Victory
        else
          (* vie perdue on replace la balle sur la raquette *)
          Playing
      in
      { ball = ball'; level = level'; score = score'; paddle = paddle'; status = status' }
    | _ ->
      (* on ne met pas à jour l'état lorsque le jeu est fini *)
      { ball; level; score; paddle; status }
  ;;

  let is_alive { ball; _ } = BALL.(ball.pv) > 0

  (** [unfold f flux e] est une sorte de [Flux.unfold] où [f] prend un second argument issu de [flux]. On l'utilise ici pour créer le flux d'états qui doit être généré avec les méthodes de mise-à-jour ET avec le flux de la souris. Son utilisation est moins abstraite si on explicite son type comme tel: [('mouse -> 'state -> 'state option) -> 'mouse Flux.t -> 'level list -> 'state -> 'state Flux.t] *)
  let rec unfold2 f flux l e =
    Tick
      (lazy
        (match Flux.uncons flux with
         | None -> None
         | Some (flux_h, flux_t) ->
           (match f flux_h l e with
            | None -> None
            | Some e' -> Some (e, unfold2 f flux_t l e'))))
  ;;

  let make_flux mouse_flux (next_levels : LEVEL.t list) initial_state =
    let f mouse next_levels state =
      if not (is_alive state) then
        Some (update mouse { state with status = GameOver })
      else if LEVEL.is_finished state.level then (
        match next_levels with
        | [] -> None
        | next_level :: next_levels_t ->
          Some (update mouse { state with level = next_level; status = Init })
      ) else
        Some (update mouse state)
    in
    unfold2 f mouse_flux next_levels initial_state
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

  let draw_pause () =
    Graphics.(
      set_color P.text_color;
      moveto 300 15;
      draw_string "Pause")
  ;;

  let middle box =
    let open BOX in
    ( int_of_float ((box.supx -. box.infx) /. 2.)
    , int_of_float ((box.supy -. box.infy) /. 2.) )
  ;;

  (* TODO: changer la taille du texte *)
  let draw_game_over state =
    Graphics.(
      let line1 = "Game Over !" in
      let line2 = Format.sprintf "Final Score: %d" state.score in
      let line1_w, _ = text_size line1 in
      let line2_w, _ = text_size line2 in
      let middle_x, middle_y = middle LEVEL.(state.level.box) in
      set_color red;
      moveto (middle_x - (line1_w / 2)) (middle_y + 10);
      draw_string line1;
      moveto (middle_x - (line2_w / 2)) (middle_y - 10);
      draw_string line2)
  ;;

  (* TODO: changer la taille du texte *)
  let draw_victory state =
    Graphics.(
      let line1 = "Victory !" in
      let line2 = Format.sprintf "Final Score: %d" state.score in
      let line1_w, _ = text_size line1 in
      let line2_w, _ = text_size line2 in
      let middle_x, middle_y = middle LEVEL.(state.level.box) in
      set_color green;
      moveto (middle_x - (line1_w / 2)) (middle_y + 10);
      draw_string line1;
      moveto (middle_x - (line2_w / 2)) (middle_y - 10);
      draw_string line2)
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
    if state.status = GameOver then
      draw_game_over state
    else if state.status = Victory then
      draw_victory state
    else if state.status = Paused then
      draw_pause ();
    (* Debug *)
    Graphics.(
      let ball = state.ball in
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
