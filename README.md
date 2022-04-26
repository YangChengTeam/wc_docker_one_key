## wc_docker_one_key

### 安装
-  **php 将所有源代码文件上传至 /home/myweb/yf-local**
-  git clone https://github.com/YangChengTeam/wc_docker_one_key.git
-  sh install.sh
-  sh pulsar_create_tenants_topics.sh
   - 等待 pulsar_manager 已启动
-  sh pulsar_manager_create_account.sh 
   - http://服务器ip:9527/#/management/tenants
   - 等待 pulsar_manager 已启动
-  sh app.sh start
