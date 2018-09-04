title: ETH钱包导入(详解)
cover: http://cdn.huodongxing.com/file/20150815/119E53CF55A897EBBFF01476D68A1A31AE/30653022772234638.jpg
author: 
  nick: James
  link: https://github.com/jameszzX
subtitle: 这次详解钱包导入的几种姿势,一起学习吧!
tags:
     - eth
     - 区块链
data: 2018-08-20 22:40:05
categories: "eth"
---
前言
===
上回我们粗略的分析下钱包的备份及导入功能,这次重点分析下导入钱包的几种方法,主要有助记词导入,keystore文件导入以及明文私钥导入。

#### ETH Wallet
另外该钱包的demo已开源到我的GitHub上了,大家可以download下来学习,仅供参考哦~!

![star我](http://p8i3gdhi6.bkt.clouddn.com/ethwallet_star.png)

Link: <https://github.com/jameszzX/eth_wallet> <span style="color:#FF5151;">Star and Fork ~!</span>

---
* 助记词导入

![助记词导入](http://p8i3gdhi6.bkt.clouddn.com/ethwallet_mnemonic.png)

由图可以看出,我们需要输入<span style="color:#FF5151;">助记词</span>并且以<span style="color:#FF5151;">空格做分隔符</span>,生成路径这里因为做的比较简单,所以强制默认生成路径为<span style="color:#FF5151;">m/44/60/0/0/0</span>,这也是大多数应用默认生成路径,需要输入<span style="color:#FF5151;">钱包密码</span>,以及选填密码提示信息,这跟Im token差不多,密码用做执行一些安全操作时的验证手段,所以<span style="color:#FF5151;">更换设备密码就不存在</span>,导入可以重新设置。

核心代码如下:

```
  let englishValid = this.bip39.validateMnemonic(
    this.mnemonic,
    this.bip39.wordlists.english
  );
  if (englishValid) {
    let seed = this.bip39.mnemonicToSeed(this.mnemonic);
    let root = this.ethers.HDNode.fromSeed(seed);
    var key1 = root.derivePath("m/44'/60'/0'/0/0");
    let privateKey = key1.privateKey;
    let wallet = new this.ethers.Wallet(privateKey);
  } else {
    this.toastText = "助记词或输入格式有误";
    this.toast = true;
    return;
  }
```

这里利用了validateMnemonic方法去验证助记词,具体可以看api,助记词正确就可以导入钱包。

* 官方钱包(KeyStore文件)导入

![keystore导入](http://p8i3gdhi6.bkt.clouddn.com/ethwallet_keystore.png)