使用说明：

v2admin:
1、主机上创建配置文件如/home/$user/v2admin/admin.yaml，设置好必要的参数，
2、创建v2admin容器：docker run -d --restart=always --name v2admin -v /home/$user/v2admin:/opt/jar/config -v /home/$user/v2admin/db:/opt/jar/db -p 8080:80 -p 9091:9091 sequent5/v2admin
3、为nginx新建配置文件，如v2admin.conf,参考例子v2admin.conf.example。
