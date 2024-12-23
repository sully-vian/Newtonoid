(** ['a Quadtree.t] représente un arbre quaternaire contenant des éléments de type ['a].
    - [Leaf l] est une feuille contenant les éléments de [l].
    - [Node (x, y, nw, ne, sw, se)] est un noeud contenant les éléments des sous-arbres [nw], [ne], [sw] et [se] *)
type 'a t =
  | Leaf of 'a list
  | Node of float * float * 'a t * 'a t * 'a t * 'a t

(** [make x y w h n] est un arbre quaternaire vide de profondeur [n] recouvrant le rectangle défini par le coin inférieur gauche de coordonnées [x, y] et les dimensions [w, h]. Attention complexité en O(4^n) ! *)
val make : float -> float -> float -> float -> int -> 'a t

(** [add q (ex, ey) e] ajoute à l'arbre quaternaire [q] l'élément [e] de coordonnées [ex] et [ey]. *)
val add : 'a t -> float * float -> 'a -> 'a t

(** [map f q] applique la fonction [f] à tous les éléments de l'arbre quaternaire [q]. *)
val map : ('a -> 'b) -> 'a t -> 'b t

(** [iter f q] applique la fonction [f] à tous les éléments de l'arbre quaternaire [q]. *)
val iter : ('a -> unit) -> 'a t -> unit

(** [string_of_quadtree f q] affiche l'arbre quaternaire [q] en utilisant la fonction [f] pour afficher les éléments. *)
val string_of_quadtree : ('a -> string) -> 'a t -> string
