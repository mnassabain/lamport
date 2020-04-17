Variables avec majuscule
Atomes minuscule

Pattern matching:
    [A, B] = [2, 3] % A = 2, B = 3
    [A, b] = [2, 3] % probleme car b != 3 ?
    [A, b] = [2, b] % ok

fonction(arg1, arg2) ->
    instruction.

Start thread:
    spawn(module, fct_name, \[args\])

instruction.

instruction1,
instruction2.

instruction_cas_1;
instruction_cas_2.

Guard: mot-clé when:
factorial(0) -> 1;
factorial(N) when N > 0 ->
N * factorial(N – 1).

Fct comme paramètres:
F = fun(X) -> 2 * X end.

Send (!)

Receiver_PID ! {message}
Receiver_PID ! Hello

Receive

receive
    pattern1 ->
        actions;
    ...;
    patternN ->
        actions
end.


Si on a pas le PID

register(name, spawn(module, function, params)),
spawn(module, ping, params)
...
dans ping:
    name ! message. % envoyer au processus par son nom


Si ping et pong sur differents postes: créer noeuds

erl -sname node_name@computer

% chaque système erlang est un noeud!

Example:

user1> erl -sname ping
ping(pong@user2).

{ pong, Pong_Node } ! message.
% ici pong = nom enregistré (register)
% Pong_Node = pong@user2
% ! Entre 2 postes il faut utiliser { REGISTERED_NAME, NODE }

user2> erl -sname pong

Pid = whereis(name).

Timeout:

receive
    pattern1 ->
        actions;
    ...;
    after TimeMs ->
        TimeoutActions
    end.

Boucle for:

for(Max, Max, F) ->
    [ F(Max) ] ;
for(I, Max, F) ->
    [ F(I) | for(I+1, Max, F) ].


RPC:

rpc(Pid, Request) ->
    Tag = erlang:make_ref(),
    Pid ! {self(), Tag, Request},
    receive
        {Tag, Response} ->
            Response
    end.

ou bien:

rpc(Pid, Request) ->
    Tag = erlang:make_ref(),
    Pid ! {self(), Tag, Request},
    Tag.

Wait_response(Tag) ->
    receive
        {Tag, Response} ->
            Response
    end.


Futures (promise & yield):

promise(Pid, Request) ->
    Tag = erlang:make_ref(),
    Pid ! {self(), Tag, Request},
    Tag.

yield(Tag) ->
    receive
        {Tag, Response} ->
            Response
    end.

% apres 

Tag = promise( Pid, fun() -> ... end ),
% Faire d’autres calculs
Val = yield(Tag).


Parallèle for/do:

par begin
    F1,
    F2
end.
