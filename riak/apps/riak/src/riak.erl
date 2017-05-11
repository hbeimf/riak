-module(riak).



-compile(export_all).

% -export([test/0, map_test/3]).

test() ->
    {ok, Pid} = riakc_pb_socket:start_link("127.0.0.1", 8087),
    Mine = riakc_obj:new(<<"people">>, <<"mine">>, ["eggs", "bacon"]),
    Yours = riakc_obj:new(<<"people">>, <<"yours">>, ["bread", "bacon"]),
    riakc_pb_socket:put(Pid, Mine),
    riakc_pb_socket:put(Pid, Yours),

    % riakc_pb_socket:mapred(
    %     Pid, <<"people">>,
    %     [{map, {qfun, fun(Obj, _, _) -> [Obj] end}, none, true}]).

    riakc_pb_socket:mapred(
        Pid, <<"people">>,
        [{map, {modfun, riak_kv_mapreduce, map_object_value},undefined, true}]).


map_test(Obj, _, _) ->
    [Obj].


t1() ->
    {ok, Pid} = riakc_pb_socket:start_link("127.0.0.1", 8087),
    Mine = riakc_obj:new(<<"people">>, <<"mine">>, ["eggs", "bacon"]),
    Yours = riakc_obj:new(<<"people">>, <<"yours">>, ["bread", "bacon"]),
    riakc_pb_socket:put(Pid, Mine),
    riakc_pb_socket:put(Pid, Yours),

    % riakc_pb_socket:mapred(
    %     Pid, <<"people">>,
    %     [{map, {qfun, fun(Obj, _, _) -> [Obj] end}, none, true}]).

    riakc_pb_socket:mapred(
        Pid, <<"people">>,
        [{map, {modfun, riak, map_test},undefined, true}]).




