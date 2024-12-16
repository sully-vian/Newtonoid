open Brick

type level = brick list

let make : brick list -> level = fun l -> l
let draw : level -> unit = fun l -> List.iter Brick.draw l

let example_level : level =
  [ Rectangle.make 0. 0. 100. 20., (1, 1)
  ; Rectangle.make 100. 0. 100. 20., (2, 2)
  ; Rectangle.make 200. 0. 100. 20., (3, 3)
  ; Rectangle.make 300. 0. 100. 20., (4, 4)
  ]
;;
