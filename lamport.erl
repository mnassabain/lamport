% Mini-projet ERLANG
% Marco NASSABAIN

-module(lamport).

-export([test/1, process/2]).


make_list(0) ->
    [];
make_list(1) ->
    [0];
make_list(N) ->
    [0 | make_list(N - 1)].


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


sendN(0, _) ->
    done;
sendN(N, Id) ->
    Dest = list_to_atom("pid" ++ integer_to_list(N)),
    Src = list_to_atom("pid" ++ integer_to_list(Id)),
    io:format("~w sending message to ~w~n", [Src, Dest]),
    Dest ! { message, Id },
    sendN(N - 1, Id).


receiveN(_, _, 0) ->
    done;
receiveN(Id, Vector, N) ->
    receive
        { message, Index } ->
            % increment counter
            CutL = lists:sublist(Vector,Index - 1),
            CutR = lists:nthtail(Index, Vector),
            NewVec = CutL ++ [lists:nth(Index,Vector) + 1] ++ CutR,
            Pidname = list_to_atom("pid" ++ integer_to_list(Id)),
            io:format("~w received message, V = ~w~n", [Pidname, NewVec]),
            receiveN(Id, NewVec, N - 1)
    end.


process(I, Vector) ->
    io:format("I am pid~w, my vector is ~w~n", [I, Vector]),
    sendN(I - 1, I),
    Nbps = length(Vector),
    receiveN(I, Vector, Nbps - I).

test(N) ->
    spawnN(N).
