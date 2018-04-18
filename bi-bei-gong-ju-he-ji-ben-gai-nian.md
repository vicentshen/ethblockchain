# 必备工具安装和配置

目前基于Eth1.8.2版本 搭建私链环境

### 环境说明

Cenos7

## 前置条件

### 安装GO

[安装链接](https://golang.org/dl/)

### 设置环境GO环境变量

```javascript
cd /root
vi .bashrc
##在文件最后配置GOROOT和GOPATH，根据自己实际位置配置
export GOROOT=/root/go/go
export GOPATH=/root/go/go
export PATH=$PATH:$GOROOT/bin
```

### 编译Go-EtherNet

#### 下载源码并安装编译

```text
wget https://github.com/ethereum/go-ethereum/archive/v1.8.2.tar.gz
tar -xvf v1.8.2.tar.gz
cd go-ethereum-1.8.2
make geth
mak all
```

## 启动私链

### 初始化

```javascript
//cd到数据目录下
cd /root/ethereum/data
mkdir conf
cd conf
```

### 新建私链配置文件

```javascript
vi genesis.json
//插入如下配置
{
  "config": {
        "chainId": 12,          
        "homesteadBlock": 0,
        "eip155Block": 0,
        "eip158Block": 0
    },
  "alloc"      : {},
  "coinbase"   : "0x0000000000000000000000000000000000000000",
  "difficulty" : "0x400",     //挖矿难度，数值越大挖矿越难，默认0x200000
  "extraData"  : "",
  "gasLimit"   : "0x2fefd8",
  "nonce"      : "0x0000000000000042",
  "mixhash"    : "0x0000000000000000000000000000000000000000000000000000000000000000",
  "parentHash" : "0x0000000000000000000000000000000000000000000000000000000000000000",      //创世块为0
  "timestamp"  : "0x00"             //创世块时间戳
}
```

用这个配置文件初始化本地数据库，上面这个配置文件决定了创世区块。

```javascript
geth --datadir /root/ethereum/data/ init /root/ethereum/data/conf/genesis.json
```

geth支持的参数

| 参数 | 说明 |
| --- | --- |
| datadir | 指定数据目录 |
| console | 启动命令行模式，可以在geth里执行命令 |
| nodiscover | 关闭p2p网络的自动发现，不会被网上看到 |
| networkid | 网络标识，私有链取一个大于4的随意的值 |

#### 初始化数据库成功之后输出如下信息

```javascript
INFO [04-17|20:41:08] Maximum peer count                       ETH=25 LES=0 total=25
INFO [04-17|20:41:08] Allocated cache and file handles         database=/root/ethereum/data/geth/chaindata cache=16 handles=16
INFO [04-17|20:41:08] Writing custom genesis block 
INFO [04-17|20:41:08] Persisted trie from memory database      nodes=0 size=0.00B time=7.08µs gcnodes=0 gcsize=0.00B gctime=0s livenodes=1 livesize=0.00B
INFO [04-17|20:41:08] Successfully wrote genesis state         database=chaindata                          hash=b052b0…1553c1
INFO [04-17|20:41:08] Allocated cache and file handles         database=/root/ethereum/data/geth/lightchaindata cache=16 handles=16
INFO [04-17|20:41:08] Writing custom genesis block 
INFO [04-17|20:41:08] Persisted trie from memory database      nodes=0 size=0.00B time=4.225µs gcnodes=0 gcsize=0.00B gctime=0s livenodes=1 livesize=0.00B
INFO [04-17|20:41:08] Successfully wrote genesis state         database=lightchaindata
```

### 启动成员节点

```javascript
geth --datadir /root/ethereum/data/ --nodiscover console 2>>eth_output.log
##成功之后会输出如下信息
Welcome to the Geth JavaScript console!

instance: Geth/v1.8.2-stable/linux-amd64/go1.10.1
 modules: admin:1.0 debug:1.0 eth:1.0 miner:1.0 net:1.0 personal:1.0 rpc:1.0 txpool:1.0 web3:1.0
```

启动成功之后，日志会输入到文件eth\_output.log中。

```javascript
tail -f eth_output.log
###查看日志
INFO [04-17|20:46:10] Disk storage enabled for ethash DAGs     dir=/root/.ethash                   count=2
INFO [04-17|20:46:10] Initialising Ethereum protocol           versions="[63 62]" network=1
INFO [04-17|20:46:10] Loaded most recent local header          number=0 hash=b052b0…1553c1 td=1024
INFO [04-17|20:46:10] Loaded most recent local full block      number=0 hash=b052b0…1553c1 td=1024
INFO [04-17|20:46:10] Loaded most recent local fast block      number=0 hash=b052b0…1553c1 td=1024
INFO [04-17|20:46:10] Regenerated local transaction journal    transactions=0 accounts=0
INFO [04-17|20:46:10] Starting P2P networking 
INFO [04-17|20:46:10] Database deduplication successful        deduped=0
INFO [04-17|20:46:10] RLPx listener up                         self="enode://e257075821fe90edfe3a182cffd340331d04de20803e6be2bfc9a7145fca103399e78b30104f1637d7b49afc11658e5cc895e588f76cd91558c17c83afeb5cff@[::]:30303?discport=0"
INFO [04-17|20:46:10] IPC endpoint opened                      url=/root/ethereum/data/geth.ipc
```

### 接下来是web3的基本操作

```javascript
//查看当前账户
web3.eth.accounts
###当前没有账号
[]
```

[web3js的github主页,之后有时间翻译](https://github.com/ethereum/wiki/wiki/JavaScript-API)

