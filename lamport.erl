% Mini-projet ERLANG
% Marco NASSABAIN

-module(lamport).

-import(lists, [max/1]).

-export([test/1, process/2]).


make_list(0) ->
    [];
make_list(1) ->
    [0];
make_list(N) ->
    [0 | make_list(N - 1)].


% incrementer valeur à une indice
incr_vect(Vector, Index) ->
    CutL = lists:sublist(Vector,Index - 1),
    CutR = lists:nthtail(Index, Vector),
    CutL ++ [lists:nth(Index,Vector) + 1] ++ CutR.


% calculer nouveau vect lors la reception d'un message
max_vect(Vector1, Vector2, Index) ->
    max_vect(Vector1, Vector2, Index, []).


max_vect([], [], _, ResVect) ->
    %%% io:format("resvect ~w~n", [ResVect]),
    ResVect;
max_vect(Vector1, Vector2, Id, ResVect) ->
    Index = length(Vector1),
    if
        Index == Id ->
            E1 = lists:nth(Index, Vector1),
            NewVect1 = lists:droplast(Vector1),
            NewVect2 = lists:droplast(Vector2),
            max_vect(NewVect1, NewVect2, Id, [ E1 | ResVect ]);
        true ->
            E1 = lists:nth(Index, Vector1),
            E2 = lists:nth(Index, Vector2),
            Elements = [E1, E2],
            Max = max(Elements),
            NewVect1 = lists:droplast(Vector1),
            NewVect2 = lists:droplast(Vector2),
            max_vect(NewVect1, NewVect2, Id, [ Max | ResVect ])
    end.


spawnN(N) when N >= 0 ->
    spawnN(N, N).


spawnN(0, _) ->
    done;
spawnN(I, N) ->
    Id = N - I + 1,
    Process = list_to_atom("pid" ++ integer_to_list(Id)),
    io:format("Creating process with name ~w~n", [Process]),
    register(Process, spawn(lamport, process, [Id, make_list(N)])),
    spawnN(I - 1, N).


sendN(0, _, Vector) ->
    Vector;
sendN(N, Id, Vector) ->
    Dest = list_to_atom("pid" ++ integer_to_list(N)),
    Src = list_to_atom("pid" ++ integer_to_list(Id)),
    NewVect = incr_vect(Vector, Id),
    io:format("~w sending message to ~w, v = ~w~n", [Src, Dest, NewVect]),
    Dest ! { message, Id, NewVect },
    sendN(N - 1, Id, NewVect).


receiveN(_, _, 0) ->
    done;
receiveN(Id, Vector, N) ->
    receive
        { message, Index, IncomingVector } ->
            % traiter vect
            NewVec = max_vect(Vector, IncomingVector, Id),
            Pidname = list_to_atom("pid" ++ integer_to_list(Id)),
            Src = list_to_atom("pid" ++ integer_to_list(Index)),
            io:format("~w received message from ~w, V = ~w~n", [Pidname, Src, NewVec]),
            receiveN(Id, NewVec, N - 1)
    end.


process(I, Vector) ->
    io:format("I am pid~w, my vector is ~w~n", [I, Vector]),
    NewVect = sendN(I - 1, I, Vector),
    Nbps = length(NewVect),
    receiveN(I, NewVect, Nbps - I).

test(N) ->
    spawnN(N).
