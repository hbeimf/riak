-module(my_map).



-export([mapfun/3]).

mapfun(RiakObject, _, _) ->


    Bucket = riak_object:bucket(RiakObject),
    Key = riak_object:key(RiakObject),
    Val = riak_object:get_values(RiakObject),
    % riak_object:get_metadatas(RiakObject),

    % [RiakObject].
    [{Bucket, Key, Val}].

