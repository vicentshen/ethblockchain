# HelloWorld

一万门语言，一万个HelloWorld！

让我们开始DApp开发的HelloWorld!

##前置条件
- 成功安装并启动Geth
- Solidity编译环境，这里使用在线环境[BrowserSolidity](https://ethereum.github.io/browser-solidity)

##启动Geth
```sh
geth --datadir ./ --nodiscover console 2>>eth_output.log
```

启动之后就可以通过命令行的方式跟geth客户端进行交互。

##几个基本操作
说明 | API函数     
---      | ---   
查看账户 | eth.accounts
获取账户余额 | eth.getBalance('账号')
生成账号 | personal.newAccount('密码')
解锁账号 | personal.unlockAccount('账号','密码')
锁定账号 | personal.lockAccount()
转账     | eth.sendTransaction({from:'转账账号',to:'收款账号',value:web3.toWei(1,'ether')})
挖矿     | miner.start()
停止挖矿 | miner.stop()
获取当前区块数| eth.blockNumber
获取区块信息 | eth.getBlock(偏移量)

##那么开始吧

首先需要创建两个账户，查看是否存在账号
```js
eth.accounts
//可以看到目前没有存在的账号
[]
```

好吧，那么我们创建两个账号
```js
//这里设置账号的密码为account1，这个后续解锁账号的时候要用
personal.newAccount('account1')
```

然后我们再看看账号是否建立好了
```js
eth.accounts
//可以看到一个账号已经建好了
["0xc1fb3c1c618baca030c6a4a1dc83948c3c417355"]
personal.newAccount('account2')
//再建立一个账号
eth.accounts
["0xc1fb3c1c618baca030c6a4a1dc83948c3c417355", "0xfed4bc66f2a00f1a457060008bea2b053f85c057"]
```

然后我们再来看看账号里面是否有钱，没钱搞个毛线。
```js
eth.getBalance(eth.accounts[0])
//好吧，没钱
0
```

接下来一个区块链中的重要角色要出场了，来来来，旷工好出现了，都迫不及待要发家致富了。

```js
//不用怀疑，就是这么简单，挖到的矿默认进入第一个账号，也可以通过geth启动的时候设置收矿账号
miner.start()
```

过不了多久，你就会有种很富有的感觉，很快就有一大把的以太币了。
光有钱还是不够的，要把钱花掉才能过一把有钱人的瘾么，哈哈...

接下来，我们从0xc1fb3c1c618baca030c6a4a1dc83948c3c417355转一波钱到0xfed4bc66f2a00f1a457060008bea2b053f85c057。

```js
//转账之前先要输入密码，这个跟支付宝啥啥的都是一样的
//解锁账号
personal.unlockAccount(eth.accounts[0],"account1")
//然后开始正式转账，转账之后，需要等旷工将交易打包到区块之后才真正的转账成功
eth.sendTransaction({from:eth.accounts[0],to:eth.accounts[1],value:web3.toWei(1,"ether")});
//然后来看看0xfed4bc66f2a00f1a457060008bea2b053f85c057是否收到钱了
eth.getBalance(eth.accounts[0])
1000000000000000000
```

如果你看到那么多零了，那就说明，转到账了，接下来才是刚到正题。

##前戏结束，开始HelloWrold

###编辑源码
请随便找个能编辑的文本编辑器完成，推荐使用Sublime（个人爱好）
```js
pragma solidity ^0.4.19;
/**
 * The hello contract does this and that...
 */
contract hello {
    string greeting;

    function hello (string _greeting) public {
        greeting = _greeting;
    }
    

    function sayHello () constant public returns (string) {
        return greeting;
    }   
}
```

###编译源码
请打开[BrowserSolidity](https://ethereum.github.io/browser-solidity)，然后将源码粘贴到输入框中去。

![源码编译](..\img\hello_compile.png)

###给变量赋值
点击上一步中的detail按钮，获取部署合约的代码

![编译后的代码](..\img\hello_compile2.png)

然后给_greeting赋值
```js
var _greeting = 'Hello World';
var helloContract = web3.eth.contract([{"constant":true,"inputs":[],"name":"sayHello","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"inputs":[{"name":"_greeting","type":"string"}],"payable":false,"stateMutability":"nonpayable","type":"constructor"}]);
var hello = helloContract.new(
   _greeting,
   {
     from: web3.eth.accounts[1], 
     data: '0x608060405234801561001057600080fd5b506040516102a83803806102a8833981018060405281019080805182019291905050508060009080519060200190610049929190610050565b50506100f5565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f1061009157805160ff19168380011785556100bf565b828001600101855582156100bf579182015b828111156100be5782518255916020019190600101906100a3565b5b5090506100cc91906100d0565b5090565b6100f291905b808211156100ee5760008160009055506001016100d6565b5090565b90565b6101a4806101046000396000f300608060405260043610610041576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063ef5fb05b14610046575b600080fd5b34801561005257600080fd5b5061005b6100d6565b6040518080602001828103825283818151815260200191508051906020019080838360005b8381101561009b578082015181840152602081019050610080565b50505050905090810190601f1680156100c85780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b606060008054600181600116156101000203166002900480601f01602080910402602001604051908101604052809291908181526020018280546001816001161561010002031660029004801561016e5780601f106101435761010080835404028352916020019161016e565b820191906000526020600020905b81548152906001019060200180831161015157829003601f168201915b50505050509050905600a165627a7a7230582052f0be1ba7f23493b1a7312270d82a5047774d6d1add9395392d4cc08e4edca40029', 
     gas: '4700000'
   }, function (e, contract){
    console.log(e, contract);
    if (typeof contract.address !== 'undefined') {
         console.log('Contract mined! address: ' + contract.address + ' transactionHash: ' + contract.transactionHash);
    }
 })
```

###部署合约
将如上代码粘贴到命令行，如果没有错误，稍微过一段时间之后看到如下说出就说明合约部署成功了
```js
Contract mined! address: 0x2f8746a78323f4f28b9cb865978f4d9f1c41ce9d transactionHash: 0xa5564ac79a22ec6c06b0f30e570e4d785742b570bc16479ff6c51607f39988e6
```

###调用合约

```js
hello.sayHello()
"Hello World"
```

至此一次顺利的HelloWorld就此结束了

###遇到的问题

####exceeds block gas limit undefined
1.减小交易的gasLimit；
2.初始化geth的时候，配置genesis.json中的gasLimit为0xffffff;