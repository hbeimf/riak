
riak-ts's hello world

==================================================================
安装

riak-ts_1.5.2-1_amd64.deb

http://www.cnblogs.com/marsprj/p/4551576.html


    # dpkg -i riak-ts_1.5.2-1_amd64.deb

3. 配置riak（配置文件/etc/riak/riak.conf）
    # cd /etc/riak
    打开riak.conf文件
    # vi /erc/riak/riak.conf
    执行命令
    %s/127.0.0.1/192.168.111.151
    将127.0.0.1替换为本机的IP地址（192.168.111.151）
4. 修改系统打开的文件数
    # ulimit -n 102400
5. 启动riak
    # riak start
    在/var/lib/riak目录下，生成riak的数据文件
6. 停止riak
    # riak stop
7. 卸载riak
    # apt-get remove riak
 启动riak后，可以看到riak进程。


列出所有的桶:

    {ok, Pid} = riakc_pb_socket:start_link("127.0.0.1", 8087).
    riakc_pb_socket:list_buckets(Pid).

====================================================================

# sudo riak help

Usage: riak «command»
This is the primary script for controlling the riak node.

 INFORMATIONAL COMMANDS
    help
        You are here.

 SERVICE CONTROL COMMANDS
    start
        Starts the riak node in the background. If the node is already
        started, you will get the message "Node is already running!" If the
        node is not already running, no output will be given.

    stop
        Stops the running riak node. Prints "ok" when successful.  When
        the node is already stopped or not responding, prints:
        "Node 'riak@127.0.0.1' not responding to pings."

    restart
        Stops and then starts the running riak node. Prints "ok"
        when successful.  When the node is already stopped or not
        responding, prints: "Node 'riak@127.0.0.1' not responding to
        pings."

    console
        Starts the riak node in the foreground, giving access to the Erlang
        shell and runtime messages. Prints "Node is already running - use
        'riak attach' instead" when the node is running in the background.

 DIAGNOSTIC COMMANDS
    ping
        Checks that the riak node is running. Prints "pong" when
        successful.  When the node is stopped or not responding, prints:
        "Node 'riak@127.0.0.1' not responding to pings."

    top [-interval N] [-sort {reductions | memory | msg_q }] [-lines N]
        Prints performance information about the Erlang Virtual Machine similar
        to the information provided by the `top` command.

        -interval N
            specifies an interval upon which the statistics are collected.

        -sort { reductions | memory | msg_q }
            Sorts the output of the command by Reduction Count, Memory
            Utilization, or Message Queue size

        -lines N
            Controls the number of processes displayed in the output

    attach
        Attaches to the console of a riak node running in the background
        using an Erlang remote shell, giving access to the Erlang shell and
        runtime messages. Prints "Node did not respond to ping!" when the
        node cannot be reached.
        Exit `riak attach` by pressing \"Ctrl-G q\".

    attach-direct
        Attaches to the console of a riak node running in the background
        using a directly connected FIFO, giving access to the Erlang shell
        and runtime messages. Prints "Node did not respond to ping!" when the
        node cannot be reached.
        Exit `riak attach-direct` by pressing \"Ctrl-D\".

    chkconfig
        Confirms whether the riak.conf and advanced.config is
        valid.

        For applications configured with cuttlefish, this includes a call
        to `config generate` also.

    config { generate | effective | describe VARIABLE } [-l debug]
        prints configuration information for applications configured with
        cuttlefish enabled. `-l debug` outputs more information for
        troubleshooting.

        generate
            generates the app.config and vm.args files from the .conf file.
            This is effectively what happens before start, but you'll need
            to use `config generate -l debug` to see the cuttlefish debug
            output.

        effective
            prints out the effective configuration in cuttlefish syntax
            including defaults not specified in the .conf file. This is
            for 'start-time' configuration only.

        describe VARIABLE
            for a given setting, prints any documentation and other useful
            information, such as affected location in app.config, datatype
            of the value, default value, and effective value.


SCRIPTING COMMANDS
    ertspath
        Outputs the path to the riak Erlang runtime environment

    escript
        Provides a means to call the `escript` application within the riak
        Erlang runtime environment

    version
        Outputs the riak version identifier

    getpid
        Outputs the process identifier for a currently running instance of
        riak.


==========================================================================

连接riak node console

    # sudo riak attach

安装个　map　函数到节点，　查看节点某些属性用这个挺方便，


=========================================================================
启动这个项目

$ rebar3 shell

    ===> Verifying dependencies...
    ===> Compiling riak
    Erlang/OTP 18 [erts-7.3] [source] [64-bit] [smp:4:4] [async-threads:0] [hipe] [kernel-poll:false]

    Eshell V7.3  (abort with ^G)
    1> riak:list_buckets().
    buckets:
     {ok,[<<"bucket1">>]}

    ok
    2>
    2> riak:list_keys(<<"bucket1">>).
    buckets:
     {ok,[<<"mine">>,<<"yours">>]}

    ok

======================================================================




