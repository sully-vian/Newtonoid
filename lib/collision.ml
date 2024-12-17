(* TODO *)
let ball_brick ball brick =
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
  if dist2 > ball.r *. ball.r then ball (* pas de collision *)
  else (
    (* check le côté de la collision *)
    let vx', vy' =
      if abs_float dx > abs_float dy then
        (* collision horizontale *)
        -.ball.vx, -.ball.vy
      else (* collision verticale *)
        ball.vx, -.ball.vy
    in
    { ball with vx = vx'; vy = vy' })
;;

(* let ball_level ball level = List.fold_left ball_brick ball level *)

let bounce_x box ball =
  let open Ball in
  let open Box in
  if ball.x -. ball.r < box.infx then
    { ball with x = box.infx +. ball.r; vx = -.ball.vx }
  else if ball.x +. ball.r > box.supx then
    { ball with x = box.supx -. ball.r; vx = -.ball.vx }
  else ball
;;

let bounce_y box ball =
  let open Ball in
  let open Box in
  if ball.y -. ball.r < box.infy then
    { ball with y = box.infy +. ball.r; vy = -.ball.vy }
  else if ball.y +. ball.r > box.supy then
    { ball with y = box.supy -. ball.r; vy = -.ball.vy }
  else ball
;;

let ball_box ball box = bounce_x box (bounce_y box ball)
