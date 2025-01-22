# Newtonoid

## TODO

- quadtree (partition quadrillée qui force le découpage du quadtree)
- passage au niveau suivant
- sons
- briques avec pouvoirs (+1 vie, balle ralentie, raquette élargie)
- pause quand click

## Pour compiler

```bash
dune build bin/newtonoid.exe
```

## Pour lancer

```bash
dune exec bin/newtonoid.exe
```

## Infos

Le code est decoupé en 2 répertoires :

- [`lib/`](./lib/) contient les modules et interfaces implémentant les divers
  éléments du jeu. Il n'implemente pas le programme principal. Le fichier
  [`lib/dune`](./lib/dune) contient une directive qui fait que dune créera une
  bibliothèque appellée Libnewtonoid contenant tous les modules de
  [`lib/`](./lib/) et utilisable par les modules de [`bin/`](./bin/). Ces
  modules peuvent utiliser les bibliothèques "graphics" et "unix" ainsi que les
  tests de la forme `let%test`.
- [`bin/`](./bin/) contient les modules du programme principal (notamment, le
  module principal : newtonoid.ml). Ces modules peuvent utiliser les modules de
  la bibliothèque libnewtonoid (en faisant un `open Libnewtonoid`). Le fichier
  [`bin/dune`](./bin/dune) ne permet pas, dans la configuration qui vous est
  donnée, que les modules de [`bin/`](./bin/) utilisent d'autres bibliothèques
  que Libnewtonoid (comme "graphics" et "unix", ou les tests `let%test`).

Le répertoire [`rapport/`](./rapport/) contiendra votre rapport au format PDF.
