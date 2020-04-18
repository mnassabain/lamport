% Mini-projet ERLANG
% Marco NASSABAIN

-module(lamport).

-export([test/1, make_list/1]).


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
    io:format("~w~n", [list_to_atom("pid" ++ integer_to_list(N))]),
    spawnN(I - 1, N).


test(N) ->
    spawnN(N).
