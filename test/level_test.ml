open Libnewtonoid

module P = Params.Make (struct
  let config_filename = "../../../configs/default.conf"
end)

module LEVEL = Level.Make (P)
open LEVEL

let%test_module "LEVEL.make" =
  (module struct
    let box = Box.Make(P).make 0. 0. 100. 100.
    let bricks = [make_brick 10. 10. BRICK.Standard; make_brick 20. 20. BRICK.Strong]
    let level = make bricks box

    let%test "level bricks" = level.bricks = bricks
    let%test "level box" = level.box = box
  end)
;;

let%test_module "LEVEL.is_finished" =
  (module struct
    let box = Box.Make(P).make 0. 0. 100. 100.
    let bricks_alive = [make_brick 10. 10. BRICK.Standard]
    let bricks_dead = [make_brick 10. 10. BRICK.Standard; make_brick 20. 20. BRICK.Strong]
    let level_alive = make bricks_alive box
    let level_dead = make bricks_dead box

    let%test "level not finished" = not (is_finished level_alive)
    let%test "level finished" = is_finished level_dead
  end)
;;

let%test_module "LEVEL.dims" =
  (module struct
    let filename = "../../../levels/level1.txt"
    let width, height = dims filename

    let%test "level width" = width > 0.
    let%test "level height" = height > 0.
  end)
;;

let%test_module "LEVEL.load" =
  (module struct
    let filename = "../../../levels/level1.txt"
    let level = load filename

    let%test "level loaded" = List.length level.bricks > 0
    let%test "level box" = level.box.BOX.width > 0. && level.box.BOX.height > 0.
  end)
;;

let%test_module "LEVEL.example_level" =
  (module struct
    let level = example_level

    let%test "example level bricks" = List.length level.bricks > 0
    let%test "example level box" = level.box.BOX.width > 0. && level.box.BOX.height > 0.
  end)
;;
