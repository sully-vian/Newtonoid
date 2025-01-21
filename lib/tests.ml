module Make (P : Params.PARAMS) = struct
  let run_test name condition =
    if condition then
      true
    else (
      Printf.printf "Test failed: %s\n" name;
      false
    )
  ;;

  let run_tests : unit -> unit =
   fun () ->
    Printf.printf "Verifying parameters...\n";
    let tests =
      [ (* Ball params Tests *)
        "ball_r > 0", P.ball_r > 0.
      ; "ball_pv > 0", P.ball_pv > 0
      ; "ball_init_vy > 0", P.ball_init_vy > 0.
      ; "ball_init_vy <= ball_max_vy", P.ball_init_vy <= P.ball_max_vy
      ; "ball_max_vx > 0", P.ball_max_vx > 0.
      ; "ball_max_vy > 0", P.ball_max_vy > 0.
      ; "ball_bounce_factor > 0", P.ball_bounce_factor > 0.
      ; (* Box params Tests *)
        "box_marge > 0", P.box_marge > 0.
      ; "box_infx = box_marge", P.box_infx = P.box_marge
      ; "box_infy = box_marge", P.box_infy = P.box_marge
      ; "box_supx > box_infx", P.box_supx > P.box_infx
      ; "box_supy > box_infy", P.box_supy > P.box_infy
      ; (* Brick params Tests *)
        "brick_weak_pv > 0", P.brick_weak_pv > 0
      ; "brick_standard_pv > brick_weak_pv", P.brick_standard_pv > P.brick_weak_pv
      ; "brick_strong_pv > brick_standard_pv", P.brick_strong_pv > P.brick_standard_pv
      ; "brick_weak_xp > 0", P.brick_weak_xp > 0
      ; "brick_standard_xp > brick_weak_xp", P.brick_standard_xp > P.brick_weak_xp
      ; "brick_strong_xp > brick_standard_xp", P.brick_strong_xp > P.brick_standard_xp
      ; (* Level params Tests *)
        "brick_w > 0", P.brick_w > 0.
      ; "brick_h > 0", P.brick_h > 0.
      ; (* Paddle params Tests *)
        "paddle_x > 0", P.paddle_x > 0.
      ; "paddle_y > 0", P.paddle_y > 0.
      ; "paddle_w > 0", P.paddle_w > 0.
      ; "paddle_h > 0", P.paddle_h > 0.
      ; (* General params Tests *)
        "dt > 0", P.dt > 0.
      ]
    in
    let results = List.map (fun (name, cond) -> run_test name cond) tests in
    if List.for_all (fun x -> x) results then
      Printf.printf "All tests passed\n"
    else (
      Printf.printf "Some tests failed\n";
      exit 1
    )
 ;;
end
