type t = Brick.t list

let make l = l
let draw l = List.iter Brick.draw l

let example_level =
  [ Brick.make (Rectangle.make 10. 10. 50. 20.) 1 1
  ; Brick.make (Rectangle.make 70. 10. 50. 20.) 2 2
  ; Brick.make (Rectangle.make 130. 10. 50. 20.) 3 3
  ; Brick.make (Rectangle.make 190. 10. 50. 20.) 4 4
  ]
;;
