## wc_docker_one_key

### 安装
-  **php 将所有源代码文件上传至 /home/myweb/yf-local**
   - 修改配置参数
      - mysql服务器名称:mysql
      - redis服务器名称:redis
      - pulsar服务器名称:pulsar
      - pulsar token: 查看./client.token
-  git clone https://github.com/YangChengTeam/wc_docker_one_key.git
-  sh install.sh
-  sh pulsar_create_tenants_topics.sh
   - 等待 pulsa 已启动
-  sh pulsar_manager_create_account.sh 
   - http://服务器ip:9527/#/management/tenants
   - 等待 pulsar_manager 已启动
-  sh app.sh start
