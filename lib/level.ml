open Params

module Make (P : PARAMS) = struct
  module BRICK = Brick.Make (P)

  type t = BRICK.t list

  let make l = l
  let make_brick x y kind = BRICK.make x y P.brick_w P.brick_h kind
  let draw l = List.iter BRICK.draw l

  let example_level =
    [ make_brick 50. 500. BRICK.Strong
    ; make_brick 100. 500. BRICK.Strong
    ; make_brick 150. 500. BRICK.Strong
    ; make_brick 200. 500. BRICK.Strong
    ; make_brick 250. 500. BRICK.Strong
    ; make_brick 300. 500. BRICK.Strong
    ; make_brick 350. 500. BRICK.Strong
    ; make_brick 400. 500. BRICK.Strong
    ; make_brick 450. 500. BRICK.Strong
    ; make_brick 500. 500. BRICK.Strong
    ; make_brick 550. 500. BRICK.Strong
    ; make_brick 600. 500. BRICK.Strong
    ; make_brick 650. 500. BRICK.Strong
    ; make_brick 700. 500. BRICK.Strong
    ; make_brick 50. 470. BRICK.Standard
    ; make_brick 100. 470. BRICK.Standard
    ; make_brick 150. 470. BRICK.Standard
    ; make_brick 200. 470. BRICK.Standard
    ; make_brick 250. 470. BRICK.Standard
    ; make_brick 300. 470. BRICK.Standard
    ; make_brick 350. 470. BRICK.Standard
    ; make_brick 400. 470. BRICK.Standard
    ; make_brick 450. 470. BRICK.Standard
    ; make_brick 500. 470. BRICK.Standard
    ; make_brick 550. 470. BRICK.Standard
    ; make_brick 600. 470. BRICK.Standard
    ; make_brick 650. 470. BRICK.Standard
    ; make_brick 700. 470. BRICK.Standard
    ; make_brick 50. 440. BRICK.Weak
    ; make_brick 100. 440. BRICK.Weak
    ; make_brick 150. 440. BRICK.Weak
    ; make_brick 200. 440. BRICK.Weak
    ; make_brick 250. 440. BRICK.Weak
    ; make_brick 300. 440. BRICK.Weak
    ; make_brick 350. 440. BRICK.Weak
    ; make_brick 400. 440. BRICK.Weak
    ; make_brick 450. 440. BRICK.Weak
    ; make_brick 500. 440. BRICK.Weak
    ; make_brick 550. 440. BRICK.Weak
    ; make_brick 600. 440. BRICK.Weak
    ; make_brick 650. 440. BRICK.Weak
    ; make_brick 700. 440. BRICK.Weak
    ; make_brick 50. 410. BRICK.Weak
    ; make_brick 100. 410. BRICK.Weak
    ; make_brick 150. 410. BRICK.Weak
    ; make_brick 200. 410. BRICK.Weak
    ; make_brick 250. 410. BRICK.Weak
    ; make_brick 300. 410. BRICK.Weak
    ; make_brick 350. 410. BRICK.Weak
    ; make_brick 400. 410. BRICK.Weak
    ; make_brick 450. 410. BRICK.Weak
    ; make_brick 500. 410. BRICK.Weak
    ; make_brick 550. 410. BRICK.Weak
    ; make_brick 600. 410. BRICK.Weak
    ; make_brick 650. 410. BRICK.Weak
    ; make_brick 700. 410. BRICK.Weak
    ]
  ;;
end
