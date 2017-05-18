-module(riak).



-compile(export_all).

% -export([test/0, map_test/3]).
% https://github.com/basho/riak
% https://github.com/basho/riak-erlang-client

list_buckets() ->
    {ok, Pid} = riakc_pb_socket:start_link("127.0.0.1", 8087),
    Buckets = riakc_pb_socket:list_buckets(Pid),
    io:format("buckets: ~n ~p~n~n", [Buckets]),
    ok.

list_keys(Bucket) ->
    {ok, Pid} = riakc_pb_socket:start_link("127.0.0.1", 8087),
    Keys = riakc_pb_socket:list_keys(Pid, Bucket),
    io:format("buckets: ~n ~p~n~n", [Keys]),
    ok.


create_demo_bucket() ->
    {ok, Pid} = riakc_pb_socket:start_link("127.0.0.1", 8087),
    Mine = riakc_obj:new(<<"bucket1">>, <<"mine">>, ["eggs", "bacon"]),
    Yours = riakc_obj:new(<<"bucket1">>, <<"yours">>, ["bread", "bacon"]),
    riakc_pb_socket:put(Pid, Mine),
    riakc_pb_socket:put(Pid, Yours),
    ok.



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


t2() ->
    {ok, Pid} = riakc_pb_socket:start_link("127.0.0.1", 8087),
    riakc_pb_socket:put(Pid, riakc_obj:new(<<"bucket5">>, <<"key1">>, term_to_binary([{1369052639, 123.3}, {1369052628, 3.3}]))),
    riakc_pb_socket:put(Pid, riakc_obj:new(<<"bucket5">>, <<"key2">>, term_to_binary([{1369052639, 123.3}, {1369052628, 3.3}]))),
    riakc_pb_socket:put(Pid, riakc_obj:new(<<"bucket5">>, <<"key3">>, term_to_binary([{1369052639, 123.3}, {1369052628, 3.3}]))),

    riakc_pb_socket:mapred(
        Pid, <<"bucket5">>,
        [{map, {modfun, my_map, mapfun},undefined, true}]).


t3() ->
    {ok, Pid} = riakc_pb_socket:start_link("127.0.0.1", 8087),
    riakc_pb_socket:put(Pid, riakc_obj:new(<<"bucket6">>, <<"key1">>, term_to_binary([{1369052639, 123.3}, {1369052628, 3.3}]))),
    riakc_pb_socket:put(Pid, riakc_obj:new(<<"bucket6">>, <<"key2">>, term_to_binary([{1369052639, 123.3}, {1369052628, 3.3}]))),
    riakc_pb_socket:put(Pid, riakc_obj:new(<<"bucket6">>, <<"key3">>, term_to_binary([{1369052639, 123.3}, {1369052628, 3.3}]))),

    riakc_pb_socket:mapred(
        Pid, <<"bucket6">>,
        [{map, {modfun, go, map_fun_demo},undefined, true}]).


 % riakc_pb_socket:list_buckets(Pid).


% s1() ->
%     {ok, Pid} = riakc_pb_socket:start_link("127.0.0.1", 8087),

%     riakc_pb_socket:put(Pid, riakc_obj:new(<<"bucket8">>, <<"key1">>, <<"egg">>)),
%     riakc_pb_socket:put(Pid, riakc_obj:new(<<"bucket8">>, <<"key2">>, <<"eggs">>)),
%     riakc_pb_socket:put(Pid, riakc_obj:new(<<"bucket8">>, <<"key3">>, <<"eggxx">>)),

%     % riakc_pb_socket:create_search_index(Pid, <<"bucket8">>),

%     riakc_pb_socket:create_search_index(Pid, <<"bucket8">>, <<"_yz_default">>, []),

%     riakc_pb_socket:search(Pid,<<"bucket8">>, list_to_binary("<<\"eggxx\">>:<<\"bread\">>"),[],5000).

    % riakc_pb_socket:search(Pid,<<"bucket8">>, <<"xx">>).


%     https://docs.basho.com/riak/kv/2.2.3/developing/usage/search/#automatic-fields

% {ok, Pid} = riakc_pb_socket:start_link("127.0.0.1", 8087).
% riakc_pb_socket:create_search_index(Pid, <<"famous">>).

% 1> {ok, Pid} = riakc_pb_socket:start_link("127.0.0.1", 8087).
% {ok,<0.128.0>}
% 2> riakc_pb_socket:create_search_index(Pid, <<"famous">>).
% ok
% 3> riakc_pb_socket:set_search_index(Pid, <<"cats">>, <<"famous">>).
% ok
% 4> {ok, Results} = riakc_pb_socket:search(Pid, <<"famous">>, <<"name_s:Lion*">>).
% {ok,{search_results,[],0.0,0}}



% ubuntu 上将map函数模块部属到riak　node 上
% /usr/lib/riak/lib
% sudo riak console
% code:which(riak_kv_mapreduce).
% /usr/lib/riak/lib/riak_kv-2.1.7-0-gbd8e312/ebin/riak_kv_mapreduce.beam

% sudo cp ./_build/default/lib/riak/ebin/my_map.beam /usr/lib/riak/lib/riak_kv-2.1.7-0-gbd8e312/ebin/

% sudo cp ./mapred_src/my_map.beam /usr/lib/riak/lib/riak_kv-2.1.7-0-gbd8e312/ebin/


% ll /usr/lib/riak/lib/riak_kv-2.1.7-0-gbd8e312/ebin/my_map.beam



% {ok, Pid} = riakc_pb_socket:start_link("myriakdb.host", 10017).


% timeseries ==============================================================================
% http://basho.com/community/
% http://docs.basho.com/riak/ts/1.5.2/#getting-started
% http://docs.basho.com/riak/ts/1.5.2/downloads/
% http://basho.com/products/riak-ts/
% http://info.basho.com/rs/721-DGT-611/images/Getting-Started-with-Riak-TS.pdf

% {ok, Pid} = riakc_pb_socket:start_link("127.0.0.1", 8087).

% riakc_ts:query(Pid, <<"
%     CREATE TABLE GeoCheckin
%     (
%        myfamily    varchar   not null,
%        myseries    varchar   not null,
%        time        timestamp not null,
%        weather     varchar   not null,
%        temperature double,
%        PRIMARY KEY (
%          (myfamily, myseries, quantum(time, 15, 'm')),
%          myfamily, myseries, time
%        )
%     )">>
% ).


% riakc_ts:put(Pid, "GeoCheckin", [{<<"family1">>, <<"series1">>, 1234567, <<"hot">>, 23.5}, {<<"family2">>, <<"series99">>, 1234567, <<"windy">>, 19.8}]).
% riakc_ts:query(Pid, "select * from GeoCheckin where time > 1234560 and time < 1234569 and myfamily = 'family1' and myseries = 'series1'").

% riakc_ts:query(Pid, "select weather, temperature from GeoCheckin where time > 1234560 and time < 1234569 and myfamily = 'family1' and myseries = 'series1'").

% riakc_ts:query(Pid, "select weather, temperature from GeoCheckin where time > 1234560 and time < 1234569 and myfamily = 'family1' and myseries = 'series1' and temperature > 27.0").


