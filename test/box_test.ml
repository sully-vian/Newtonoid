open Libnewtonoid

module P = Params.Make (struct
  let config_filename = "../../../configs/default.conf"
end)

module BOX = Box.Make (P)
open BOX

let%test_module "BOX.make" =
  (module struct
    let%test "make creates box with correct attributes 1" =
      let box = BOX.make 7.34 8.23 15.02 11.55 in
      box.marge = P.box_marge
      && box.infx = 7.34
      && box.infy = 8.23
      && box.supx = 15.02
      && box.supy = 11.55
    ;;

    let%test "make creates box with correct attributes 2" =
      let box = BOX.make 10.0 20.0 30.0 40.0 in
      box.marge = P.box_marge
      && box.infx = 10.0
      && box.infy = 20.0
      && box.supx = 30.0
      && box.supy = 40.0
    ;;

    let%test "make creates box with correct attributes 3" =
      let box = BOX.make 0.0 0.0 50.0 50.0 in
      box.marge = P.box_marge
      && box.infx = 0.0
      && box.infy = 0.0
      && box.supx = 50.0
      && box.supy = 50.0
    ;;

    let%test "make creates box with correct attributes 4" =
      let box = BOX.make 25.5 35.5 75.5 85.5 in
      box.marge = P.box_marge
      && box.infx = 25.5
      && box.infy = 35.5
      && box.supx = 75.5
      && box.supy = 85.5
    ;;
  end)
;;

let%test_module "BOX.middle" =
  (module struct
    let%test "middle of square box" =
      let box = make 0. 0. 100. 100. in
      let x, y = middle box in
      x = 50 && y = 50
    ;;

    let%test "middle of rectangular box" =
      let box = make 0. 0. 200. 100. in
      let x, y = middle box in
      x = 100 && y = 50
    ;;

    let%test "middle with margin" =
      let box = make P.box_marge P.box_marge 100. 100. in
      let x, y = middle box in
      x = 45 && y = 45
    ;;

    let%test "middle with non-zero origin" =
      let box = make 50. 50. 150. 150. in
      let x, y = middle box in
      x = 50 && y = 50
    ;;
  end)
;;
