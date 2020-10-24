# seafile-arm64-docker

### 系统要求

- SQLite版本：1GB或以上RAM的ARM64机器
- MariaDB版本：2GB或以上RAM的ARM64机器
   - 例如：树莓派4，小睿私人云，乐橙sn1（hi3798c+2G+SATA），斐讯N1

### 部署方法

1. 安装好docker和docker-compose

2. 下载docker-compose配置文件
   - 如果要部署SQLite版本，下载[docker-compose-sqlite.yml](docker-compose-sqlite.yml)，并重命名为`docker-compose.yml`
   - 如果要部署MariaDB版本，下载[docker-compose.yml](docker-compose.yml)

3. 修改`docker-compose.yml`
     - volumes: MariaDB和seafile的数据目录挂载点，修改`:`前的路径为本机实际目录，该目录必须有足够的空间
     - SEAFILE_ADMIN_EMAIL: seafile管理员账号邮箱
     - SEAFILE_ADMIN_PASSWORD: seafile管理员密码
     - SEAFILE_SERVER_HOSTNAME: seafile服务器域名，可以设置成IP地址或者hostname，如`192.168.1.8`或者`raspberrypi`
     - MYSQL_ROOT_PASSWORD, DB_ROOT_PASSWD: （仅MariaDB版本）MariaDB的root密码，必须配置成相同的值

4. 在`docker-compose.yml`所在的目录下运行`docker-compose up -d`

5. 等待容器启动完毕（可能需要3分钟），访问`http://<SEAFILE_SERVER_HOSTNAME>:80`

### 常见问题

#### 如何查看seafile运行日志？

```
docker logs seafile
```

#### 如何开启seafdav？

1. 修改`<seafile.volumes>/data/seafile/conf/seafdav.conf`，把`enabled`和`fastcgi`选项都改成`true`

2. 重新启动seafile容器

3. 访问`http://<SEAFILE_SERVER_HOSTNAME>/seafdav`

#### 如何更新seafile？
```
docker pull hanwckf/seafile:latest
docker-compose down
docker-compose up -d
```

### 参考资料

- https://cloud.seafile.com/published/seafile-manual-cn/docker/%E7%94%A8Docker%E9%83%A8%E7%BD%B2Seafile.md
- https://github.com/hanwckf/seafile-arm64-build
