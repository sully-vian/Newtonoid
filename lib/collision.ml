open Params

module Make (P : PARAMS) = struct
  module BRICK = Brick.Make (P)
  module BALL = Ball.Make (P)
  module PADDLE = Paddle.Make (P)
  module BOX = Box.Make (P)
  module LEVEL = Level.Make (P)

  let with_brick (ball : BALL.t) (brick : BRICK.t) =
    let closest_x = max BRICK.(brick.x) (min BALL.(ball.x) BRICK.(brick.x +. brick.w)) in
    let closest_y = max BRICK.(brick.y) (min BALL.(ball.y) BRICK.(brick.y +. brick.h)) in
    BALL.(
      let dx = closest_x -. ball.x in
      let dy = closest_y -. ball.y in
      let dist2 = (dx *. dx) +. (dy *. dy) in
      (* check si collision *)
      if dist2 > ball.r *. ball.r then
        (* pas de collision *)
        ball, brick
      else (
        (* check le côté de la collision *)
        let x', y', vx', vy' =
          if abs_float dx > abs_float dy then
            (* collision horizontale *)
            if ball.vx > 0. then
              ( (* collision à gauche *)
                brick.BRICK.x -. ball.r -. 1.
              , ball.y
              , -.abs_float ball.vx *. P.ball_bounce_factor
              , ball.vy )
            else
              ( (* collision à droite *)
                brick.BRICK.x +. brick.BRICK.w +. ball.r +. 1.
              , ball.y
              , abs_float ball.vx *. P.ball_bounce_factor
              , ball.vy )
          else if (* collision verticale *)
                  ball.vy > 0. then
            ( (* collision en bas *)
              ball.x
            , brick.BRICK.y -. ball.r -. 1.
            , ball.vx
            , -.abs_float ball.vy *. P.ball_bounce_factor )
          else
            ( (* collision en haut *)
              ball.x
            , brick.BRICK.y +. brick.BRICK.h +. ball.r +. 1.
            , ball.vx
            , abs_float ball.vy *. P.ball_bounce_factor )
        in
        (* mise-à-jour des vitesses et perte d'un point de vie pour la brique *)
        bound_speed { ball with x = x'; y = y'; vx = vx'; vy = vy' }, BRICK.damage 1 brick
      ))
  ;;

  let update_score_and_level ball brick level score =
    if BRICK.is_alive brick then
      (* si la brique est vivante, on la garde *)
      ball, LEVEL.{ level with bricks = brick :: level.bricks }, score
    else (
      (* sinon, on récupère son xp *)
      let xp = BRICK.get_xp brick in
      ball, level, score + xp
    )
  ;;

  let rec with_level ball level score =
    match LEVEL.(level.bricks) with
    | [] -> ball, level, score
    | brick :: bricks_t ->
      (* collision courante *)
      let ball_after, brick_after = with_brick ball brick in
      (* reste du niveau *)
      let level_t = LEVEL.{ level with bricks = bricks_t } in
      let final_ball, level_after, score_after = with_level ball_after level_t score in
      update_score_and_level final_ball brick_after level_after score_after
  ;;

  let bounce_x box ball =
    let open BALL in
    let open BOX in
    bound_speed
      (if ball.x -. ball.r < box.infx then
         (* Collision avec le bord gauche *)
         { ball with x = box.infx +. ball.r; vx = -.ball.vx *. P.ball_bounce_factor }
       else if ball.x +. ball.r > box.supx then
         (* Collision avec le bord droit *)
         { ball with x = box.supx -. ball.r; vx = -.ball.vx *. P.ball_bounce_factor }
       else
         ball)
  ;;

  let bounce_y box ball =
    let open BALL in
    let open BOX in
    bound_speed
      (if ball.y -. ball.r < box.infy then
         (* Collision avec le bord bas *)
         { ball with
           y = box.infy +. ball.r
         ; vy = -.ball.vy *. P.ball_bounce_factor
         ; pv = ball.pv - 1
         }
       else if ball.y +. ball.r > box.supy then
         (* Collision avec le bord haut *)
         { ball with y = box.supy -. ball.r; vy = -.ball.vy *. P.ball_bounce_factor }
       else
         ball)
  ;;

  let with_box box ball = bounce_x box (bounce_y box ball)

  let with_paddle ball paddle =
    (* check si balle dans la zone de la raquette *)
    let in_range_x =
      (BALL.(ball.x +. ball.r) > PADDLE.(paddle.x))
      && BALL.(ball.x -. ball.r) < PADDLE.(paddle.x +. paddle.w)
    in
    let in_range_y = BALL.(ball.y +. ball.r) > PADDLE.(paddle.y) in
    let descending = BALL.(ball.vy < 0.) in
    (* impulsion donnée par la raquette *)
    let impulse = PADDLE.(paddle.vx) /. 10. in
    (* balle rebondit vers le haut *)
    let paddle_top = PADDLE.(paddle.y +. paddle.h) in
    if in_range_x && in_range_y && BALL.(ball.y -. ball.r) < paddle_top && descending then
      BALL.(
        bound_speed
          { ball with
            y = paddle_top
          ; vx = ball.vx +. impulse
          ; vy =
              abs_float ball.vy
              *. P.ball_bounce_factor (* la balle rebondit vers le haut *)
          })
    else
      ball
  ;;
end
