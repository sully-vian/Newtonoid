open Libnewtonoid

module P = Params.Make (struct
  let config_filename = "../../../configs/default.conf"
end)

open Utils

let%test_module "Utils.unfold2" =
  (module struct
    let f x acc = if x > 0 then Some (acc + x) else None
    let flux = Flux.of_list [3; 2; 1; 0; -1]
    let result = unfold2 f flux 0

    let%test "unfold2 result" =
      let rec to_list flux =
        match Flux.uncons flux with
        | None -> []
        | Some (x, xs) -> x :: to_list xs
      in
      to_list result = [0; 3; 5; 6]
  end)
;;

let%test_module "Utils.parse_key_value_pairs" =
  (module struct
    let input = "key1 = value1\nkey2 = value2\n# comment\nkey3 = value3\n"
    let chan = Scanf.Scanning.from_string input
    let result = parse_key_value_pairs chan

    let%test "parse key value pairs" =
      result = [("key3", "value3"); ("key2", "value2"); ("key1", "value1")]
  end)
;;

let%test_module "Utils.color_of_string" =
  (module struct
    let color_str = "255 0 0"
    let color = color_of_string color_str

    let%test "color of string" = color = Graphics.rgb 255 0 0
  end)
;;

let%test_module "Utils.assoc" =
  (module struct
    let alist = [("key1", "value1"); ("key2", "value2")]

    let%test "assoc existing key" = assoc alist "key1" = "value1"
    let%test "assoc non-existing key" =
      try
        let _ = assoc alist "key3" in
        false
      with
      | _ -> true
  end)
;;

let%test_module "Utils.assoc_int" =
  (module struct
    let alist = [("key1", "1"); ("key2", "2.5")]

    let%test "assoc int existing key" = assoc_int alist "key1" = 1
    let%test "assoc int non-integer value" =
      try
        let _ = assoc_int alist "key2" in
        false
      with
      | _ -> true
  end)
;;

let%test_module "Utils.assoc_float" =
  (module struct
    let alist = [("key1", "1.0"); ("key2", "2.5")]

    let%test "assoc float existing key" = assoc_float alist "key1" = 1.0
    let%test "assoc float existing key 2" = assoc_float alist "key2" = 2.5
  end)
;;

let%test_module "Utils.assoc_color" =
  (module struct
    let alist = [("key1", "255 0 0"); ("key2", "0 255 0")]

    let%test "assoc color existing key" = assoc_color alist "key1" = Graphics.rgb 255 0 0
    let%test "assoc color existing key 2" = assoc_color alist "key2" = Graphics.rgb 0 255 0
  end)
;;
