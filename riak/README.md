http://stackoverflow.com/questions/15950139/completely-confused-about-mapreduce-in-riak-erlangs-riakc-client

There are 2 Riak Erlang clients that serve different purposes.

The first one is the internal Riak client that is included in the riak_kv module (riak_client.erl and riak_object.erl).
This can be used if you are attached to the Riak console or if you are writing a MapReduce function or a commit hook.
As it is run from within a Riak node it works quite well with qfuns.

The other client is the official Riak client for Erlang that is used by external applications
and connects to Riak through the protocol buffers interface. This is what you are using in your example above.
As this connects through protocol buffers,
it is usually recommended that MapReduce functions in Erlang are compiled
and deployed on the nodes of the cluster as named functions.
This will also make them accessible from other client libraries.



