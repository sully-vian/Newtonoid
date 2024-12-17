type t = Brick.t list

let make l = l
let draw l = List.iter Brick.draw l

let example_level =
  [ Brick.make (Rectangle.make 10. 10. 50. 20.) Brick.Weak
  ; Brick.make (Rectangle.make 70. 10. 50. 20.) Brick.Standard
  ; Brick.make (Rectangle.make 130. 10. 50. 20.) Brick.Strong
  ; Brick.make (Rectangle.make 190. 10. 50. 20.) Brick.Unbreakable
  ]
;;
