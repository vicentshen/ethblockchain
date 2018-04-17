# 必备工具和基本概念

目前基于Eth1.8.2版本搭建私链环境
###环境说明
Cenos7
##前置条件
###安装GO
安装连接[https://golang.org/dl/]
###设置环境GO环境变量
```js
cd /root
vi .bashrc
##在文件最后配置GOROOT和GOPATH，根据自己实际位置配置
export GOROOT=/root/go/go
export GOPATH=/root/go/go
export PATH=$PATH:$GOROOT/bin
```
###编译Go-EtherNet
####下载源码并安装编译

```shell
wget https://github.com/ethereum/go-ethereum/archive/v1.8.2.tar.gz
tar -xvf v1.8.2.tar.gz
cd go-ethereum-1.8.2
make geth
mak all
```
