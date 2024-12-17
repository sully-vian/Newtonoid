type t = Ball.t * Level.t * int

let update box dt (ball, level, score) =
  let ball', level', score' =
    Collision.(ball_level (ball_box (Ball.update ball dt) box) level score)
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
