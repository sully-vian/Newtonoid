open Iterator

(** [mouse] génère un flux infini d'états de la souris.
    Chaque élément est une paire (x, pressed) où:
    - x est l'abscisse actuelle de la souris
    - pressed est true si un bouton de la souris est pressé.

    Le stream se met à jour continuellement *)
val mouse : (float * bool) flux
