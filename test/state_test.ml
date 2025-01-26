open Libnewtonoid

module P = Params.Make (struct
  let config_filename = "../../../configs/default.conf"
end)

module STATE = State.Make (P)
module LEVEL = Level.Make (P)
module BOX = Box.Make (P)
module BALL = Ball.Make (P)
module PADDLE = Paddle.Make (P)
module BRICK = Brick.Make (P)
open STATE

let%test_module "STATE.make" =
  (module struct
    let box = BOX.make 0. 0. 100. 100.
    let bricks = [LEVEL.make_brick 10. 10. BRICK.Standard; LEVEL.make_brick 20. 20. BRICK.Strong]
    let level = LEVEL.make bricks box
    let state = STATE.make level 0

    let%test "initial state ball" = state.ball = BALL.make
    let%test "initial state level" = state.level = level
    let%test "initial state score" = state.score = 0
    let%test "initial state paddle" = state.paddle = PADDLE.make
    let%test "initial state status" = state.status = Init
  end)
;;

let%test_module "STATE.update" =
  (module struct
    let box = BOX.make 0. 0. 100. 100.
    let bricks = [LEVEL.make_brick 10. 10. BRICK.Standard; LEVEL.make_brick 20. 20. BRICK.Strong]
    let level = LEVEL.make bricks box
    let state = STATE.make level 0

    let%test "update state init to playing" =
      let updated_state = STATE.update (50., true) state in
      updated_state.status = Playing

    let%test "update state playing to paused" =
      let state_playing = { state with status = Playing } in
      let updated_state = STATE.update (50., true) state_playing in
      updated_state.status = Paused

    let%test "update state paused to playing" =
      let state_paused = { state with status = Paused } in
      let updated_state = STATE.update (50., true) state_paused in
      updated_state.status = Playing

    let%test "update state playing to game over" =
      let state_playing = { state with status = Playing; ball = { state.ball with pv = 0 } } in
      let updated_state = STATE.update (50., false) state_playing in
      updated_state.status = GameOver

    let%test "update state playing to victory" =
      let bricks_dead = [] in
      let level_dead = LEVEL.make bricks_dead box in
      let state_playing = { state with status = Playing; level = level_dead } in
      let updated_state = STATE.update (50., false) state_playing in
      updated_state.status = Victory
  end)
;;

let%test_module "STATE.is_alive" =
  (module struct
    let box = BOX.make 0. 0. 100. 100.
    let bricks = [LEVEL.make_brick 10. 10. BRICK.Standard; LEVEL.make_brick 20. 20. BRICK.Strong]
    let level = LEVEL.make bricks box
    let state = STATE.make level 0

    let%test "state is alive" = STATE.is_alive state

    let%test "state is not alive" =
      let state_dead = { state with ball = { state.ball with pv = 0 } } in
      not (STATE.is_alive state_dead)
  end)
;;
(*
let%test_module "STATE.make_flux" =
  (module struct
    let box = BOX.make 0. 0. 100. 100.
    let bricks = [LEVEL.make_brick 10. 10. BRICK.Standard; LEVEL.make_brick 20. 20. BRICK.Strong]
    let level = LEVEL.make bricks box
    let state = STATE.make level 0
    let mouse_events = [(50., true); (50., false)]
    let state_flux = STATE.make_flux (Iterator.Flux.unfold 
    (fun l -> match l with [] -> None | h::t -> Some(h,t)) mouse_events) 
    (state, [])

    let%test "state flux initial state" =
      match Iterator.Flux.uncons state_flux with
      | Some (s, _) -> s.status = Init
      | None -> false

    let%test "state flux playing state" =
      let state_flux' = Iterator.Flux.unfold (fun flux -> match Iterator.Flux.uncons flux with
      | Some (_, rest) -> Some((),rest)
      | None -> None) state_flux 
    in
      match Iterator.Flux.uncons state_flux' with
      | Some (s, _) -> s.status = Playing
      | None -> false
  end)
;;
*)