type t = Ball.t * Level.t * int

let update box dt (ball, level, score) =
  let ball', level', score' =
    Collision.(with_level (with_box (Ball.update ball dt) box) level score)
  in
  ball', level', score'
;;

let update2 box dt paddle (ball, level, score) =
  let ball', level', score' =
    Collision.(
      with_level
        (with_box (with_paddle (Ball.update ball dt) paddle) box)
        level
        score)
  in
  ball', level', score'
;;

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
    moveto 10 10;
    draw_string (Format.sprintf "Score : %d" score))
;;
