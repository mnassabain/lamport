# Mini-projet ERLANG

**Marco Nassabain M1 SIL**

## Sujet

L'objectif de ce mini-projet est d'implémenter en Erlang l'estampillage vectoriel de Lamport, afin de synchroniser la communication au sein d'un ensemble de processus distribués.

On considère un ensemble de N processus (N étant paramétrable), munis d'horloges vectorielles. Chaque fois qu'un processus émet/reçoit un message vers/en provenance des autres processus, il applique le mécanisme d'estampillage vectoriel de Lamport vu en cours.

On vous demande d'implémenter une communication entre ces N processus, chaque processus envoyant un à plusieurs messages à tous les autres processus.

Afin de tester votre programme, ce module comportera une fonction 'test' (dont N sera un argument), qui permettra de lancer la communication de messages entre N processus.

L'affichage devra tracer de façon **très lisible** les estampilles des messages échangés, et les mises à jour des horloges vectorielles des N processus.

## Code


## Remarques
