title: 简单创建ETH钱包
cover: https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1531818456&di=f35388b692ad8ef1d0d3bbcc7bc22a30&imgtype=jpg&er=1&src=http%3A%2F%2Fn1.itc.cn%2Fimg8%2Fwb%2Fsmccloud%2F2015%2F07%2F24%2F143771973369960292.JPEG
author: 
  nick: James
  link: https://github.com/jameszzX
subtitle: 教你如何简单的创建一个属于你的ETH钱包
tags:
     - eth
     - 区块链
data: 2018-07-10 22:40:05
categories: "eth"
---
前言
===
记录自己摸索ETC钱包的点点滴滴,加油努力!

### ethers.js
一个实现以太坊底层实现原理的javascript库

web可以直接引入库
```
<script src="https://cdn.ethers.io/scripts/ethers-v3.min.js" charset="utf-8" type="text/javascript"></script>

//npm
npm install --save ethers
```

### bip39
一个生成密钥相关的助记词生成库(ethers.js也能实现生成助记词,但是貌似只能生成英文词语)
```
npm i bip39
```
---
### 简单实现生成ETH钱包

使用bip39生成助记词:

1.生成指定位数的助记词,也可不传递参数,默认为128位长度,即12个助记词,可传递128~256长度,最长为24个助记词.
```
bip39.generateMnemonic(length)
```

2.默认生成为英文助记词,生成中文可以传递语言表参数,如下第一个参数为长度,第二个参数是rng,传null就行(我也不知道这个参数干啥的),第三个为字符表参数:
```
let str = bip39.generateMnemonic(160,null,bip39.wordlists.chinese_simplified); //生成中文简体
```

3.通用字符表参数
```
wordlists: {
    EN: ENGLISH_WORDLIST,
    JA: JAPANESE_WORDLIST,

    chinese_simplified: CHINESE_SIMPLIFIED_WORDLIST,
    chinese_traditional: CHINESE_TRADITIONAL_WORDLIST,
    english: ENGLISH_WORDLIST,
    french: FRENCH_WORDLIST,
    italian: ITALIAN_WORDLIST,
    japanese: JAPANESE_WORDLIST,
    korean: KOREAN_WORDLIST,
    spanish: SPANISH_WORDLIST
  }
```

4.把助记词(如果有设置密码)转成种子,传入助记词和密码(如果有的话):
```
let password = 'james';
let send = bip39.mnemonicToSeed(str, password);
```

5.使用ethers将种子生成root主节点：
```
let root = ethers.HDNode.fromSeed(seed);
```

6.从主节点生成第一个eth钱包节点：
```
var key1 = root.derivePath("m/44'/60'/0'/0/0");  // 推荐路径
console.log(key1);
let privateKey = key1.privateKey;  // 私钥
```

6.使用ethers将私钥生成ETH钱包并获得地址:
```
let wallet = new ethers.Wallet(privateKey);
console.log("Address: "+ wallet.address);
```

至此已生成一个eth钱包账户.

---
#### 如果只记得助记词和密码(如果有的话),怎么找回eth钱包呢?(好问题滑稽脸)

1.还是使用bip39传入助记词和密码生成种子:
```
let words = "衡 穿 格 已 央 食 守 郑 驱 馏 卸 而";
let send = bip39.mnemonicToSeed(words,'james');
```

2.在ethers使用钱包种子生成root主节点:
```
let root = ethers.HDNode.fromSeed(send);
let privateKey = root.privateKey; //得到私钥
```

3.利用root生成任意钱包节点:
```
var key1 = root.derivePath("m/44'/60'/0'/0/0");
console.log(key1);
let privateKey = key1.privateKey;
```

3.用ethers将私钥生成钱包并获得地址:
```
let wallet = new ethers.Wallet(privateKey);
console.log("Address: " + wallet.address)
```

成功找回钱包啦,注意如果在创建钱包时使用了口令,那么找回时就必须要助记词+密码,缺一不可,短短几行代码让我越发对区块链及虚拟货币感兴趣!~

> 内容参考
>
> [分层确定性钱包 HD Wallet 介绍](http://bigshark.club/2017/10/20/intr-hd-wallet/)
>
> [数字货币钱包详解(译)](https://juejin.im/post/5ae2942ff265da0b886d23df)
>
> [数字货币钱包详解(原文)](https://github.com/ethereumbook/ethereumbook/blob/develop/wallets.asciidoc)

总结
---
本次只是总结了下摸索eth钱包创建的过程,萌新能力有限,希望能帮到有需要的人!溜了溜了~