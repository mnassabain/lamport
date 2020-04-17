# Estampillage vectoriel de Lamport

## Principe

Chaque processus `p` contient un vecteur `c` de taille `n`, qui correspond au nombre de processus en total.

Chaque élément `c[i]` de cet vecteur contient **l'horloge de Lamport** du processus correspondant.

Il est mis à jour selon les règles suivantes:
* Un événement interne provoque l'incrémentation de l'estampille[p]
* Avant l'envoie d'un message, l'estampille[p] est incrémenté et le message est envoyé avec la nouvelle estampille
* lors la réception d'un message, chaque composante j != p prend la valeur max(estampille_courante[j], estampille_message[j]).

Pour comparer deux horloges on dit que a précède b ssi:
* $\forall$i, a[i] <= b[i]
* $\exists$i, tq a[i] < b[i]

C'est à dire toutes les datations sont inf ou égales, mais il y a au moins strictement inférieure

Si a <! b && b <! a, alors elles sont **indépendantes et incomparables**

## Exemple

Soit 3 processus, p1, p2, p3. Chacun a son estampille, chacune composée de trois numéros ou dates, les trois correspondant à chaque processus :

```
estampille p1 : [0 (date pour p1), 0 (pour p2), 0 (pour p3)]
estampille p2 : [0, 0, 0]
estampille p3 : [0, 0, 0]
```
Imaginons qu'il se produise un évènement interne à p1. Les estampilles deviendront :
```
estampille p1 : [1, 0, 0]
estampille p2 : [0, 0, 0]
estampille p3 : [0, 0, 0]
```
Imaginons maintenant que p1 envoie un message à p3. À l'émission, les estampilles deviendront :
```
estampille p1 : [2, 0, 0]
estampille p2 : [0, 0, 0]
estampille p3 : [0, 0, 0]
```
Le message portera comme estampille [2, 0, 0], qui correspond à l'estampille de p1 lors de l'émission.

À la réception, les estampilles deviendront :
```
estampille p1 : [2, 0, 0]
estampille p2 : [0, 0, 0]
estampille p3 : [2, 0, 1]
```
