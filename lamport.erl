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


spawnN(0) ->
    done;
spawnN(N) when N > 0 ->
    spawnN(N, N).


spawnN(0, _) ->
    done;
spawnN(I, N) ->
    Id = N - I + 1,
    Process = list_to_atom("pid" ++ integer_to_list(Id)),
    io:format("Creating process with name ~w~n", [Process]),
    register(Process, spawn(lamport, process, [Id, make_list(N)])),
    spawnN(I - 1, N).


process(I, Vector) ->
    io:format("I am pid ~w, my vector is ~w~n", [I, Vector]).


test(N) ->
    spawnN(N).
