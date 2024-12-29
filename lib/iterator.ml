(* interface des itérateurs (implémentée par les flux) *)
module type Intf = sig
  type 'a t

  (** flux vide *)
  val vide : 'a t

  val cons : 'a -> 'a t -> 'a t
  val unfold : ('s -> ('a * 's) option) -> 's -> 'a t
  val filter : ('a -> bool) -> 'a t -> 'a t
  val append : 'a t -> 'a t -> 'a t
  val constant : 'a -> 'a t
  val map : ('a -> 'b) -> 'a t -> 'b t
  val uncons : 'a t -> ('a * 'a t) option
  val apply : ('a -> 'b) t -> 'a t -> 'b t
  val map2 : ('a -> 'b -> 'c) -> 'a t -> 'b t -> 'c t
end

type 'a flux = Tick of ('a * 'a flux) option Lazy.t

(** Module implémentant l'interface [Intf] avec des flux *)
module Flux : Intf with type 'a t = 'a flux = struct
  (** [t] est le type des flux *)
  type 'a t = 'a flux = Tick of ('a * 'a t) option Lazy.t

  (** [vide] est le flux vide *)
  let vide = Tick (lazy None)

  (** [cons t q] ajoute l'élément [t] en tête du flux [q] *)
  let cons t q = Tick (lazy (Some (t, q)))

  (** [uncons flux] retourne le premier élément du flux [flux] et le reste du flux *)
  let uncons (Tick (lazy flux)) = flux

  (** [apply <<f1; f2; ...>> <<a1; a2; ...>>] applique le flux de fonctions au flux d'argument et revoie [<<f1 a1; f2 a2; ...>>] *)
  let rec apply f x =
    Tick
      (lazy
        (match uncons f, uncons x with
         | None, _ -> None
         | _, None -> None
         | Some (tf, qf), Some (tx, qx) -> Some (tf tx, apply qf qx)))

  (** [unfold f e] crée un flux à partir d'une fonction [f] et d'une valeur initiale [e]. Le retour ressemble à [<<f e; f (f e); f (f (f e)); ...>>] *)
  let rec unfold f e =
    Tick
      (lazy
        (match f e with
         | None -> None
         | Some (t, e') -> Some (t, unfold f e')))

  (** [filter p flux] filtre les éléments du flux [flux] selon le prédicat [p] *)
  let rec filter p flux =
    Tick
      (lazy
        (match uncons flux with
         | None -> None
         | Some (t, q) ->
           if p t then
             Some (t, filter p q)
           else
             uncons (filter p q)))

  (** [append flux1 flux2] concatène les flux [flux1] et [flux2] *)
  let rec append flux1 flux2 =
    Tick
      (lazy
        (match uncons flux1 with
         | None -> uncons flux2
         | Some (t1, q1) -> Some (t1, append q1 flux2)))

  (** [constant c] crée un flux infini de constantes [c] *)
  let constant c = unfold (fun () -> Some (c, ())) ()

  (** [map f i] applique la fonction [f] à tous les éléments du flux [i] *)
  let map f i = apply (constant f) i

  (** [map2 f <<a1; a2; ...>> <<b1; b2; ...>>] applique la fonction [f] aux éléments correspondants des deux flux et renvoie [<<f a1 b1; f a2 b2; ...>>] *)
  let map2 f i1 i2 = apply (apply (constant f) i1) i2
end
