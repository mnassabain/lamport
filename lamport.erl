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
    % register & spawn process
    % pass N to process so that it knows its index in table
    % pass vector (list) of n-elements
    io:format("~w~n", [list_to_atom("pid" ++ integer_to_list(N))]),
    spawnN(N - 1).


test(N) ->
    spawnN(N).
