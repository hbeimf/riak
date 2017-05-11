#!/bin/bash

rm -rf ./_build/default/lib/riak
rm -rf ./rebar.lock

rebar3 shell --name riak_test@127.0.0.1 --setcookie riak


