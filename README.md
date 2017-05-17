http://www.cnblogs.com/marsprj/p/4551576.html


http://docs.basho.com/riak/kv/2.2.3/downloads/
riak_2.2.3-1_amd64.deb


一、安装riak

1. 安装包：riak_2.0.2-1_amd64.deb
   路    径：~/software/riak_2.0.2-1_amd64.deb
2. 安装riak
    $ su - root
    # cd /home/ubuntu/software
    # dpkg -i riak_2.0.2-1_amd64.deb
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
