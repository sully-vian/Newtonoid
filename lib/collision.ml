let with_brick ball brick =
  let open Rectangle in
  let open Ball in
  let open Brick in
  let rect = brick.rect in
  let closest_x = max rect.x (min ball.x (rect.x +. rect.w)) in
  let closest_y = max rect.y (min ball.y (rect.y +. rect.h)) in
  let dx = closest_x -. ball.x in
  let dy = closest_y -. ball.y in
  let dist2 = (dx *. dx) +. (dy *. dy) in
  (* check si collision *)
  if dist2 > ball.r *. ball.r then
    ball, brick
  (* pas de collision *)
  else (
    (* check le côté de la collision *)
    let x', y', vx', vy' =
      if abs_float dx > abs_float dy then
        (* collision horizontale *)
        if ball.x +. ball.r > rect.x then
          (* collision à gauche de la brique *)
          rect.x -. ball.r, ball.y, -.ball.vx, ball.vy
        else if ball.x -. ball.r < rect.x +. rect.w then
          (* collision à droite de la brique *)
          rect.x +. rect.w +. ball.r, ball.y, -.ball.vx, ball.vy
        else
          ball.x, ball.y, -.ball.vx, ball.vy
      else if (* collision verticale *)
              ball.y -. ball.r < rect.y +. rect.h then
        (* collision au dessus de la brique *)
        ball.x, rect.y +. rect.h +. ball.r, ball.vx, -.ball.vy
      else if ball.y +. ball.r > rect.y then
        (* collision en dessous de la brique *)
        ball.x, rect.y -. ball.r, ball.vx, -.ball.vy
      else
        ball.x, ball.y, ball.vx, -.ball.vy
    in
    (* mise-à-jour des vitesses et perte d'un point de vie pour la brique *)
    ( { ball with x = x'; y = y'; vx = vx'; vy = vy' }
    , { brick with pv = brick.pv - 1 } )
  )
;;

let update_score_and_level ball brick level score =
  if Brick.is_alive brick then
    ball, brick :: level, score
  else (
    (* On exclue la brique lorsqu'elle est détruite *)
    let xp = Brick.xp brick in
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
    let final_ball, level_after, score_after =
      with_level ball_after level_t score
    in
    update_score_and_level final_ball brick_after level_after score_after
;;

let bounce_x box ball =
  let open Ball in
  let open Box in
  if ball.x -. ball.r < box.infx then
    { ball with x = box.infx +. ball.r; vx = -.ball.vx }
  else if ball.x +. ball.r > box.supx then
    { ball with x = box.supx -. ball.r; vx = -.ball.vx }
  else
    ball
;;

let bounce_y box ball =
  let open Ball in
  let open Box in
  if ball.y -. ball.r < box.infy then
    { ball with y = box.infy +. ball.r; vy = -.ball.vy }
  else if ball.y +. ball.r > box.supy then
    { ball with y = box.supy -. ball.r; vy = -.ball.vy }
  else
    ball
;;

let with_box ball box = bounce_x box (bounce_y box ball)

let with_paddle (ball : Ball.t) (paddle : Paddle.t) =
  let closest_x = max paddle.x (min ball.x (paddle.x +. paddle.w)) in
  let closest_y = max paddle.y (min ball.y (paddle.y +. paddle.h)) in
  let dx = closest_x -. ball.x in
  let dy = closest_y -. ball.y in
  let dist2 = (dx *. dx) +. (dy *. dy) in
  (* check si collision *)
  if dist2 > ball.r *. ball.r then
    ball
  (* pas de collision *)
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
    (* mise-à-jour des vitesses *)
    { ball with vx = vx'; vy = vy' }
  )
;;
