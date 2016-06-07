LNMP:ansible-playbook
============

  简单的ansible playbook，用来初始化系统，并安装php5.5和nginx1.2.7。指定vhosts的域名进行nginx的vhosts配置。
  
init system
------------
        ansible-playbook site.yml --tags=init --limit=test
  指定tags=init，执行初始化系统的操作；limit=test，指定对hosts文件里面的test组下用户执行操作，如果不指定，则对hosts文件里面的所有用户执行操作。
  
install nginx
------------
        ansible-playbook site.yml --tags=nginx --limit=test
  指定tags=nginx，执行安装nginx的操作，指定对test用户组进行操作。
  
install php
------------
        ansible-playbook site.yml --tags=php --limit=test
  指定tags=php，执行安装php操作,并安装配置memcache，指定对test用户组进行操作。
  
config nginx
------------
        ansible-playbook site.yml --tags=nginx_conf --limit=test --extra-vars "domain_name=car.api.hunantv.com code_dir=app-mobile-api"
        
  指定tags=nginx_conf，执行配置nginx的vhost操作。--extra-vars必须有，指定playbooks需要的变量。
  
  domain_name：变量，指定vhost的域名
  
  code_dir：变量，用来指定vhosts的webroot。例如：webroot为/data/www/1.hunantv.com/app-mobile-api/public 中间的app-mobile-api则使用这个变量。
  
lvs loopback config
-------------
        ansible-playbook site.yml --tags=lvs --limit=test --extra-vars "lvs_loop=192.168.12.12"

  指定指定tags为lvs的role，执行配置lvs环回接口。--extra-vars必须有，执行lvs的环回地址变量

  
ALL
------------
        ansible-playbook site.yml --limit=test --extra-vars "domain_name=car.api.hunantv.com code_dir=app-mobile-api lvs_loop=192.168.12.12"
  如果不指定tags，则执行包括初始化，安装nginx，php，配置vhosts和lvs的环回地址所有工作。--extra-vars这指定了整个playbooks需要的变量，包括域名，代码目录和环回地址。
  
