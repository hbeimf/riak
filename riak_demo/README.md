
在riak node上启动自己的app

1>复制自己的应用
$ sudo cp -R /web/demo/http_server/_build/default/rel/http_server/lib/go-0.1.0 /usr/lib/riak/lib/
$ sudo chmod 777 /usr/lib/riak/lib/go-0.1.0 -R

2>连上riak结点
$ sudo riak attach

3>增加路径
code:add_pathz("/usr/lib/riak/lib/go-0.1.0/ebin").

4>启动应用
application:start(go).

application:stop(go).
