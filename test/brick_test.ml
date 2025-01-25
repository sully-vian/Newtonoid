open Libnewtonoid

module P = Params.Make (struct
  let config_filename = "../../../configs/default.conf"
end)

module BRICK = Brick.Make (P)
open BRICK

let%test_module "BRICK.make" =
  (module struct
    let%test "make creates brick with correct attributes 1" =
      let brick = make 10.1 20.2 30.3 40.4 BRICK.Standard in
      brick.x = 10.1
      && brick.y = 20.2
      && brick.w = 30.3
      && brick.h = 40.4
      && brick.pv = P.brick_standard_pv
      && brick.kind = BRICK.Standard
    ;;

    let%test "make creates brick with correct attributes 2" =
      let brick = make 123.4 234.5 345.6 456.7 BRICK.Strong in
      brick.x = 123.4
      && brick.y = 234.5
      && brick.w = 345.6
      && brick.h = 456.7
      && brick.pv = P.brick_strong_pv
      && brick.kind = BRICK.Strong
    ;;

    let%test "make creates brick with correct attributes 3" =
      let brick = make 567.8 678.9 789.0 890.1 BRICK.Weak in
      brick.x = 567.8
      && brick.y = 678.9
      && brick.w = 789.0
      && brick.h = 890.1
      && brick.pv = P.brick_weak_pv
      && brick.kind = BRICK.Weak
    ;;

    let%test "make creates brick with correct attributes 4" =
      let brick = make 901.2 123.3 234.4 345.5 BRICK.Unbreakable in
      brick.x = 901.2 && brick.y = 123.3 && brick.w = 234.4 && brick.h = 345.5
    ;;
  end)
;;

let%test_module "BRICK.get_init_pv" =
  (module struct
    let%test "correct pv for Weak" = get_init_pv BRICK.Weak = P.brick_weak_pv
    let%test "correct pv for Standard" = get_init_pv BRICK.Standard = P.brick_standard_pv
    let%test "correct pv for Strong" = get_init_pv BRICK.Strong = P.brick_strong_pv
  end)
;;

let%test_module "BRICK.get_xp" =
  (module struct
    let%test "correct xp for Weak" =
      let brick = make 23. 3. 31. 7. BRICK.Weak in
      get_xp brick = P.brick_weak_xp
    ;;

    let%test "correct xp for Standard" =
      let brick = make 11. 19. 17. 13. BRICK.Standard in
      get_xp brick = P.brick_standard_xp
    ;;

    let%test "correct xp for Strong" =
      let brick = make 2. 29. 5. 37. BRICK.Strong in
      get_xp brick = P.brick_strong_xp
    ;;
  end)
;;

let%test_module "BRICK.get_color" =
  (module struct
    let%test "correct color for Weak" =
      let brick = make 23. 3. 31. 7. BRICK.Weak in
      get_color brick = P.brick_weak_color
    ;;

    let%test "correct color for Standard" =
      let brick = make 11. 19. 17. 13. BRICK.Standard in
      get_color brick = P.brick_standard_color
    ;;

    let%test "correct color for Strong" =
      let brick = make 2. 29. 5. 37. BRICK.Strong in
      get_color brick = P.brick_strong_color
    ;;
  end)
;;

let%test_module "BRICK.is_alive" =
  (module struct
    let%test "alive brick" =
      let brick = make 23. 3. 31. 7. BRICK.Weak in
      is_alive brick
    ;;

    let%test "dead brick" =
      let brick = make 23. 3. 31. 7. BRICK.Weak in
      let brick' = { brick with pv = 0 } in
      not (is_alive brick')
    ;;

    let%test "alive unbreakable brick" =
      let brick = make 23. 3. 31. 7. BRICK.Unbreakable in
      is_alive brick
    ;;
  end)
;;

let%test_module "BRICK.damage" =
  (module struct
    let%test "damage weak brick" =
      let brick = make 23. 3. 31. 7. BRICK.Weak in
      let brick' = damage 1 brick in
      brick' = { brick with pv = brick.pv - 1 }
    ;;

    let%test "damage standard brick" =
      let brick = make 23. 3. 31. 7. BRICK.Standard in
      let brick' = damage 1 brick in
      brick' = { brick with pv = brick.pv - 1 }
    ;;

    let%test "damage strong brick" =
      let brick = make 23. 3. 31. 7. BRICK.Strong in
      let brick' = damage 1 brick in
      brick' = { brick with pv = brick.pv - 1 }
    ;;

    let%test "damage unbreakable brick" =
      let brick = make 23. 3. 31. 7. BRICK.Unbreakable in
      let brick' = damage 1 brick in
      brick' = brick
    ;;
  end)
;;

let%test_module "BRICK.inner_rect" =
  (module struct
    let%test "inner rect weak brick" =
      let brick = make 23. 3. 31. 7. BRICK.Weak in
      let x, y, w, h = inner_rect brick in
      x = 23. && y = 3. && w = 31. && h = 7.
    ;;

    let%test "inner rect standard brick" =
      let brick = make 23. 3. 31. 7. BRICK.Standard in
      let x, y, w, h = inner_rect brick in
      x = 23. && y = 3. && w = 31. && h = 7.
    ;;

    let%test "inner rect strong brick" =
      let brick = make 23. 3. 31. 7. BRICK.Strong in
      let x, y, w, h = inner_rect brick in
      x = 23. && y = 3. && w = 31. && h = 7.
    ;;

    let%test "inner rect unbreakable brick" =
      let brick = make 23. 3. 31. 7. BRICK.Unbreakable in
      let x, y, w, h = inner_rect brick in
      x = 23. && y = 3. && w = 31. && h = 7.
    ;;

    let%test "inner rect damaged standard brick" =
      let brick = make 100. 50. 6. 6. BRICK.Standard in
      let brick' = damage 1 brick in
      let x, y, w, h = inner_rect brick' in
      x = 101. && y = 51. && w = 4. && h = 4.
    ;;

    let%test "inner rect damaged twice standard brick" =
      let brick = make 100. 50. 6. 6. BRICK.Standard in
      let brick' = damage 2 brick in
      let x, y, w, h = inner_rect brick' in
      x = 102. && y = 52. && w = 2. && h = 2.
    ;;
  end)
;;
