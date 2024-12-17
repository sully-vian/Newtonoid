type t = Brick.t list

let make l = l
let width = 50.
let height = 30.
let make_brick x y kind = Brick.make (Rectangle.make x y width height) kind
let draw l = List.iter Brick.draw l

let example_level =
  [ make_brick 50. 500. Brick.Strong
  ; make_brick 100. 500. Brick.Strong
  ; make_brick 150. 500. Brick.Strong
  ; make_brick 200. 500. Brick.Strong
  ; make_brick 250. 500. Brick.Strong
  ; make_brick 300. 500. Brick.Strong
  ; make_brick 350. 500. Brick.Strong
  ; make_brick 400. 500. Brick.Strong
  ; make_brick 450. 500. Brick.Strong
  ; make_brick 500. 500. Brick.Strong
  ; make_brick 550. 500. Brick.Strong
  ; make_brick 600. 500. Brick.Strong
  ; make_brick 650. 500. Brick.Strong
  ; make_brick 700. 500. Brick.Strong
  ; make_brick 50. 470. Brick.Standard
  ; make_brick 100. 470. Brick.Standard
  ; make_brick 150. 470. Brick.Standard
  ; make_brick 200. 470. Brick.Standard
  ; make_brick 250. 470. Brick.Standard
  ; make_brick 300. 470. Brick.Standard
  ; make_brick 350. 470. Brick.Standard
  ; make_brick 400. 470. Brick.Standard
  ; make_brick 450. 470. Brick.Standard
  ; make_brick 500. 470. Brick.Standard
  ; make_brick 550. 470. Brick.Standard
  ; make_brick 600. 470. Brick.Standard
  ; make_brick 650. 470. Brick.Standard
  ; make_brick 700. 470. Brick.Standard
  ; make_brick 50. 440. Brick.Weak
  ; make_brick 100. 440. Brick.Weak
  ; make_brick 150. 440. Brick.Weak
  ; make_brick 200. 440. Brick.Weak
  ; make_brick 250. 440. Brick.Weak
  ; make_brick 300. 440. Brick.Weak
  ; make_brick 350. 440. Brick.Weak
  ; make_brick 400. 440. Brick.Weak
  ; make_brick 450. 440. Brick.Weak
  ; make_brick 500. 440. Brick.Weak
  ; make_brick 550. 440. Brick.Weak
  ; make_brick 600. 440. Brick.Weak
  ; make_brick 650. 440. Brick.Weak
  ; make_brick 700. 440. Brick.Weak
  ; make_brick 50. 410. Brick.Weak
  ; make_brick 100. 410. Brick.Weak
  ; make_brick 150. 410. Brick.Weak
  ; make_brick 200. 410. Brick.Weak
  ; make_brick 250. 410. Brick.Weak
  ; make_brick 300. 410. Brick.Weak
  ; make_brick 350. 410. Brick.Weak
  ; make_brick 400. 410. Brick.Weak
  ; make_brick 450. 410. Brick.Weak
  ; make_brick 500. 410. Brick.Weak
  ; make_brick 550. 410. Brick.Weak
  ; make_brick 600. 410. Brick.Weak
  ; make_brick 650. 410. Brick.Weak
  ; make_brick 700. 410. Brick.Weak
  ]
;;
