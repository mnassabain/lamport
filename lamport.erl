% Mini-projet ERLANG
% Marco NASSABAIN

-module(lamport).

-export([test/1]).


spawnN(0) ->
    done;
spawnN(N) when N > 0 ->
    io:format("~w~n", [list_to_atom("pid" ++ integer_to_list(N))]),
    spawnN(N - 1).


test(N) ->
    spawnN(N).
