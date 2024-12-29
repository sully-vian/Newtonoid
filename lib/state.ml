open Iterator
open Params

module Make (P : PARAMS) = struct
  module BALL = Ball.Make (P)
  module PADDLE = Paddle.Make (P)
  module LEVEL = Level.Make (P)
  module COLLISION = Collision.Make (P)

  type game_status =
    | Playing
    | Init

  type t =
    { ball : BALL.t
    ; level : LEVEL.t
    ; score : int
    ; paddle : PADDLE.t
    ; status : game_status
    }

  let update box (x_mouse, click) { ball; level; score; paddle; status } =
    match status with
    | Init ->
      let paddle' = PADDLE.update box x_mouse paddle in
      let ball' =
        let x' = PADDLE.(paddle'.x +. (paddle'.w /. 2.)) in
        let y' = PADDLE.(paddle'.y +. paddle'.h) +. BALL.(ball.r) in
        BALL.{ ball with x = x'; y = y'; vx = 0.; vy = P.ball_init_vy }
      in
      let status' =
        if click then
          Playing
        else
          Init
      in
      { ball = ball'; level; score; paddle = paddle'; status = status' }
    | Playing ->
      let paddle' = PADDLE.update box x_mouse paddle in
      let ball', level', score' =
        let after_update = BALL.move ball in
        COLLISION.(
          let after_paddle = with_paddle after_update paddle in
          let after_box = with_box after_paddle box in
          let after_level = with_level after_box level score in
          after_level)
      in
      let status' =
        if BALL.(ball.pv == ball'.pv) then
          Playing
        else
          Init
      in
      { ball = ball'; level = level'; score = score'; paddle = paddle'; status = status' }

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

  let make_flux box mouse_flux initial_state =
    let f mouse state =
      if is_alive state then
        Some (update box mouse state)
      else
        None
    in
    unfold2 f mouse_flux initial_state

  let draw { ball; level; score; paddle; _ } =
    LEVEL.draw_shadow level;
    PADDLE.draw_shadow paddle;
    BALL.draw_shadow ball;
    LEVEL.draw level;
    PADDLE.draw paddle;
    BALL.draw ball;
    Graphics.(
      set_color black;
      moveto 15 30;
      draw_string (Format.sprintf "Score : %d" score);
      moveto 15 15;
      draw_string (Format.sprintf "PVs : %d" BALL.(ball.pv));
      moveto 100 15;
      draw_string (Format.sprintf "ball x: %d" (int_of_float BALL.(ball.x)));
      moveto 100 30;
      draw_string (Format.sprintf "ball y: %d" (int_of_float BALL.(ball.y)));
      moveto 175 15;
      draw_string (Format.sprintf "ball vx: %d" (int_of_float BALL.(ball.vx)));
      moveto 175 30;
      draw_string (Format.sprintf "ball vy: %d" (int_of_float BALL.(ball.vy))))
end
