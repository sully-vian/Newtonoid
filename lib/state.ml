open Iterator

type t =
  { ball : Ball.t
  ; level : Level.t
  ; score : int
  ; paddle : Paddle.t
  }

let update box dt (x_mouse, _) { ball; level; score; paddle } =
  let paddle' = Paddle.update box x_mouse paddle in
  let ball', level', score' =
    let after_update = Ball.move ball dt in
    Collision.(
      let after_paddle = with_paddle after_update paddle in
      let after_box = with_box after_paddle box in
      let after_level = with_level after_box level score in
      after_level)
  in
  { ball = ball'; level = level'; score = score'; paddle = paddle' }
;;

let is_alive { ball; level = _; score = _; paddle = _ } = Ball.(ball.pv) > 0

let draw { ball; level; score; paddle } =
  Paddle.draw paddle;
  Ball.draw ball;
  Level.draw level;
  Graphics.(
    set_color black;
    moveto 15 30;
    draw_string (Format.sprintf "Score : %d" score);
    moveto 15 15;
    draw_string (Format.sprintf "PVs : %d" Ball.(ball.pv)))
;;

(** [unfold f flux e] est une sorte de [Flux.unfold] où [f] prend un second argument issu de [flux]. On l'utilise ici pour créer le flux d'états qui doit être généré avec les méthodes de mise-à-jour ET avec le flux de la souris. Son utilisation est moins abstraite si on explicite son type comme tel: [('mouse -> 'state -> 'state option) -> 'mouse Flux.t -> 'state -> 'state Flux.t] *)
let rec unfold2 f flux e =
  Tick
    (lazy
      (match Flux.uncons flux with
       | None -> None
       | Some (flux_h, flux_t) ->
         (match f flux_h e with
          | None -> None
          | Some e' -> Some (e, unfold2 f flux_t e'))))
;;

let make_flux box dt mouse_flux initial_state =
  let f mouse state = Some (update box dt mouse state) in
  unfold2 f mouse_flux initial_state
;;
