type t = Ball.t * Level.t * int

let update box dt (ball, level, score) =
  let ball', level', score' =
    Collision.(with_level (with_box (Ball.update ball dt) box) level score)
  in
  ball', level', score'
;;

let update2 box dt paddle (ball, level, score) =
  let ball', level', score' =
    let after_update = Ball.update ball dt in
    Collision.(
      let after_paddle = with_paddle after_update paddle in
      let after_box = with_box after_paddle box in
      let after_level = with_level after_box level score in
      after_level)
  in
  ball', level', score'
;;

let is_alive (ball, _, _) = ball.Ball.pv > 0

let draw (ball, level, score) =
  Ball.draw ball;
  Level.draw level;
  Graphics.(
    set_color black;
    moveto 10 10;
    draw_string (Format.sprintf "Score : %d" score))
;;

let draw2 paddle (ball, level, score) =
  Paddle.draw paddle;
  Ball.draw ball;
  Level.draw level;
  Graphics.(
    set_color black;
    moveto 15 20;
    draw_string (Format.sprintf "Score : %d" score);
    moveto 15 10;
    draw_string (Format.sprintf "PV : %d" ball.pv))
;;
