
#创建mongodb.tgz解压目录
mkdir  -p   /opt/servers/mongodb_demo/

#到mongodb安装包目录
cd    /opt/software

#解压
tar -zxvf  mongodb-linux-x86_64-rhel70-6.0.3.tgz -C   /opt/servers/mongodb_demo/

#修改名称
cd  /opt/servers/mongodb_demo/
ls  
mv   mongodb-linux-x86_64-rhel70-6.0.3   mongodb
# 创建数据目录
mkdir  -p   standalone/data/db/

#存入日志文件目录
mkdir   standalone/logs

#配置环境变量
vi  ~/.bash_profile

# 按 i进入编辑模式
# 要插入内容
# export PATH=/opt/servers/mongodb_demo/mongodb/bin:$PATH
# 按：  进入末行模式
# 按:wq 保存退出
#使环境变量生效
source ~/.bash_profile

#查找mongodb服务
ps -ef |  grep mongod

#杀死进程
kill -2  20136

# 方式1： 启动 mongodb命令
mongod --dbpath=/opt/servers/mongodb_demo/standalone/data/db --logpath=/opt/servers/mongodb_demo/standalone/logs/mongodblogs.log -fork

#方式2（配置文件）： 启动 mongodb命令
mongod -f  /opt/servers/mongodb_demo/mongodb/conf/mongod.conf   
 
#永久开放27017端口：
firewall-cmd --zone=public --permanent --add-port=27017/tcp; firewall-cmd --reload

#数据库授权
use test
db.createUser({user: "root", pwd: "123456", roles: [{ role: "dbOwner", db: "test" }]})

