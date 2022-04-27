## wc_docker_one_key

### 安装
-  服务器上安装 git
-  **php 将所有源代码文件上传至 /home/myweb/yf-local**
   - 修改配置参数
      - mysql服务器名称:mysql
      - redis服务器名称:redis
      - pulsar服务器名称:pulsar
      - pulsar token: 查看./client.token
-  git clone https://github.com/YangChengTeam/wc_docker_one_key.git
-  sh install.sh
-  sh pulsar_create_tenants_topics.sh
   - 等待 pulsar 已启动
-  sh pulsar_manager_create_account.sh 
   - http://服务器ip:9527/#/management/tenants
   - 等待 pulsar_manager 已启动
-  sh app.sh config && sh app.sh start


### 管理

- php 
    - 测试地址: http://服务器ip:3000/gateway/v1.test/parkinglot

- pulsar_manager
    - 管理地址:  http://服务器ip:9527/
        - 帐号： admin
        - 密码： qq123456

    - 添加Enviroment
        - 名称
        - 地址: http://pulsar:8080

- redis 管理
    - 管理地址:  服务器ip   
    - 端口： 6379
    - 密码:  123456

- mysql 管理
    - 管理地址:  服务器ip   
    - 端口： 3306
    - 密码:  123456