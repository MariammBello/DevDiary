
# lxc

## Instance name: ubuntu-container <br/>

ssh on only wsl: <br/>
```ssh -i Altschool-keypair-1.pem root@10.87.5.186```<br/>
Proxy configuration command for webserver: <br/>
```sudo lxc config device add ubuntu-container myproxy80 proxy listen=tcp:0.0.0.0:8888 connect=tcp:127.0.0.1:80 bind=host```<br/>
Proxy configuration command for ssh (ssh listens on 22):<br/>
```sudo lxc config device add ubuntu-container myproxy22 proxy listen=tcp:0.0.0.0:2222 connect=tcp:127.0.0.1:22 bind=host```  <br/>
Universal ssh into instance 
```ssh -i Altschool-keypair-1.pem -p 2222 root@localhost ```


## Instance name: ubuntu-container2 <br/>

ssh on only wsl: <br/>
```-ssh -i Altschool-keypair-1.pem root@10.87.5.3```<br/>
Proxy configuration command for webserver: <br/>
```none defined for this instance```<br/>
Proxy configuration command for ssh (ssh listens on 22):<br/>
```sudo lxc config device add ubuntu-container2 myproxy22-2 proxy listen=tcp:0.0.0.0:2223 connect=tcp:127.0.0.1:22 bind=host```  <br/>
Universal ssh into instance 
```ssh -i Altschool-keypair-1.pem -p 2223 root@localhost```
