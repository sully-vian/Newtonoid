open Params

module Make (P : PARAMS) = struct
  module BRICK = Brick.Make (P)
  module BALL = Ball.Make (P)
  module BOX = Box.Make (P)
  module PADDLE = Paddle.Make (P)

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
        let vx', vy' =
          if abs_float dx > abs_float dy then
            (* collision horizontale *)
            -.ball.vx, ball.vy
          else
            (* collision verticale *)
            ball.vx, -.ball.vy
        in
        (* mise-à-jour des vitesses et perte d'un point de vie pour la brique *)
        { ball with vx = vx'; vy = vy' }, BRICK.damage 1 brick
      ))
  ;;

  let update_score_and_level ball brick level score =
    if BRICK.is_alive brick then
      ball, brick :: level, score
    else (
      (* On exclue la brique lorsqu'elle est détruite *)
      let xp = BRICK.xp brick in
      ball, level, score + xp
    )
  ;;

  let rec with_level ball level score =
    match level with
    | [] -> ball, level, score
    | brick :: level_t ->
      (* collision courante *)
      let ball_after, brick_after = with_brick ball brick in
      (* reste du niveau *)
      let final_ball, level_after, score_after = with_level ball_after level_t score in
      update_score_and_level final_ball brick_after level_after score_after
  ;;

  let bounce_x box ball =
    let open BALL in
    let open BOX in
    if ball.x -. ball.r < box.infx then
      (* Collision avec le bord gauche *)
      { ball with x = box.infx +. ball.r; vx = -.ball.vx }
    else if ball.x +. ball.r > box.supx then
      (* Collision avec le bord droit *)
      { ball with x = box.supx -. ball.r; vx = -.ball.vx }
    else
      ball
  ;;

  let bounce_y box ball =
    let open BALL in
    let open BOX in
    if ball.y -. ball.r < box.infy then
      (* Collision avec le bord bas *)
      { ball with y = box.infy +. ball.r; vy = -.ball.vy; pv = ball.pv - 1 }
    else if ball.y +. ball.r > box.supy then
      (* Collision avec le bord haut *)
      { ball with y = box.supy -. ball.r; vy = -.ball.vy }
    else
      ball
  ;;

  let with_box ball box = bounce_x box (bounce_y box ball)

  let with_paddle (ball : BALL.t) (paddle : PADDLE.t) =
    let ball_in_range =
      (BALL.(ball.x +. ball.r) > PADDLE.(paddle.x))
      && BALL.(ball.x -. ball.r) < PADDLE.(paddle.x +. paddle.w)
    in
    let descending = BALL.(ball.vy < 0.) in
    let vx = BALL.(ball.vx) +. (PADDLE.(paddle.vx) /. 10.) in
    let vy = abs_float BALL.(ball.vy) in
    let paddle_top = PADDLE.(paddle.y +. paddle.h) in
    if ball_in_range && BALL.(ball.y -. ball.r) < paddle_top && descending then
      BALL.{ ball with y = paddle_top; vx; vy }
    else
      ball
  ;;
end
