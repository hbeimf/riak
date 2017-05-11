-module(riak).



-compile(export_all).

% -export([test/0, map_test/3]).

test() ->
    {ok, Pid} = riakc_pb_socket:start_link("127.0.0.1", 8087),
    Mine = riakc_obj:new(<<"bucket1">>, <<"mine">>, ["eggs", "bacon"]),
    Yours = riakc_obj:new(<<"bucket1">>, <<"yours">>, ["bread", "bacon"]),
    riakc_pb_socket:put(Pid, Mine),
    riakc_pb_socket:put(Pid, Yours),

    % riakc_pb_socket:mapred(
    %     Pid, <<"bucket1">>,
    %     [{map, {qfun, fun(Obj, _, _) -> [Obj] end}, none, true}]).

    riakc_pb_socket:mapred(
        Pid, <<"bucket1">>,
        [{map, {modfun, riak_kv_mapreduce, map_object_value},undefined, true}]).


map_test(Obj, _, _) ->
    [Obj].


t1() ->
    {ok, Pid} = riakc_pb_socket:start_link("127.0.0.1", 8087),
    Mine = riakc_obj:new(<<"bucket1">>, <<"mine">>, ["eggs", "bacon"]),
    Yours = riakc_obj:new(<<"bucket1">>, <<"yours">>, ["bread", "bacon"]),
    riakc_pb_socket:put(Pid, Mine),
    riakc_pb_socket:put(Pid, Yours),

    % riakc_pb_socket:mapred(
    %     Pid, <<"bucket1">>,
    %     [{map, {qfun, fun(Obj, _, _) -> [Obj] end}, none, true}]).

    riakc_pb_socket:mapred(
        Pid, <<"bucket1">>,
        [{map, {modfun, my_map, mapfun},undefined, true}]).




% ubuntu 上将map函数模块部属到riak　node 上
% /usr/lib/riak/lib
% sudo riak console
% code:which(riak_kv_mapreduce).
% /usr/lib/riak/lib/riak_kv-2.1.7-0-gbd8e312/ebin/riak_kv_mapreduce.beam

% sudo cp ./_build/default/lib/riak/ebin/my_map.beam /usr/lib/riak/lib/riak_kv-2.1.7-0-gbd8e312/ebin/

% ll /usr/lib/riak/lib/riak_kv-2.1.7-0-gbd8e312/ebin/my_map.beam
