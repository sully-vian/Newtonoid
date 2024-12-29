type 'a t =
  | Leaf of 'a list
  | Node of float * float * 'a t * 'a t * 'a t * 'a t

let rec make x y w h n =
  if n = 0 then
    Leaf []
  else (
    (* point central *)
    let x' = x +. (w /. 2.) in
    let y' = y +. (h /. 2.) in
    let w' = w /. 2. in
    let h' = h /. 2. in
    (* création des sous-arbres *)
    let nw = make x y' w' h' (n - 1) in
    let ne = make x' y' w' h' (n - 1) in
    let sw = make x y w' h' (n - 1) in
    let se = make x' y w' h' (n - 1) in
    Node (x', y', nw, ne, sw, se)
  )

let rec add q (ex, ey) e =
  match q with
  | Leaf l -> Leaf (e :: l)
  | Node (x, y, nw, ne, sw, se) ->
    if ex > x then
      if ey < y then
        (* ajout à nw *)
        Node (x, y, add nw (ex, ey) e, ne, sw, se)
      else
        (* ajout à ne *)
        Node (x, y, nw, add ne (ex, ey) e, sw, se)
    else if ey < y then
      (* ajout à sw *)
      Node (x, y, nw, ne, add sw (ex, ey) e, se)
    else
      (* ajout à se *)
      Node (x, y, nw, ne, sw, add se (ex, ey) e)

let rec map f q =
  match q with
  | Leaf l -> Leaf (List.map f l)
  | Node (x, y, nw, ne, sw, se) -> Node (x, y, map f nw, map f ne, map f sw, map f se)

let rec iter f q =
  match q with
  | Leaf l -> List.iter f l
  | Node (_, _, nw, ne, sw, se) ->
    iter f nw;
    iter f ne;
    iter f sw;
    iter f se

let rec string_of_quadtree f q =
  match q with
  | Leaf l -> Printf.sprintf "Leaf [%s]" (String.concat "; " (List.map f l))
  | Node (x, y, nw, ne, sw, se) ->
    Printf.sprintf
      "Node (%f, %f, %s, %s, %s, %s)"
      x
      y
      (string_of_quadtree f nw)
      (string_of_quadtree f ne)
      (string_of_quadtree f sw)
      (string_of_quadtree f se)
