-module(my_map).



-export([mapfun/3, test/0]).

mapfun(RiakObject, _, _) ->


    Bucket = riak_object:bucket(RiakObject),
    Key = riak_object:key(RiakObject),
    Val = riak_object:get_value(RiakObject),
    % riak_object:get_metadatas(RiakObject),

    % [RiakObject].
    [{Bucket, Key, binary_to_term(Val)}].


test() ->
    io:format("test!!!~n").


% code:which(riak_kv_mapreduce).
% =========================

% sudo cp /web/riak/mapred_src/my_map.beam /usr/lib/riak/lib/riak_kv-2.1.7-0-gbd8e312/ebin/
% sudo riak attach

% code:purge(my_map).
% code:load_file(my_map).

% my_map:test().
