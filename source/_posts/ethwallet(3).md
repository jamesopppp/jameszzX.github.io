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

这里利用了<span style="color:#FF5151;">Bip39</span>的<span style="color:#FF5151;">validateMnemonic</span>这个Api去验证助记词正确性,具体可以看api,助记词正确就可以导入钱包。

* 官方钱包(Keystore文件)导入

![keystore导入](http://p8i3gdhi6.bkt.clouddn.com/ethwallet_keystore.png)

Keystore导入只需要一段<span style="color:#FF5151;">Keystore文本</span>和一个<span style="color:#FF5151;">Keystore密码</span>就可以执行导入,Keystore密码一般在导出时可以设置,Im token的做法是将钱包密码设置为Keystore密码,导入时也将Keystore密码设置为钱包密码,我们后面的导出也会这么做,只要密码正确就能通过Keystore文本重新找回钱包。

核心代码如下:

```
  this.ethers.Wallet.fromEncryptedWallet(
    this.keyStore,
    this.keyStorePassword
  ).then(function(wallet) {
      console.log("Wallet Address: " + wallet.address);
    })
    .catch(function(err) {
      console.log(err);
      this.toastText = "keystore文本或密码错误";
      this.toast = true;
    });
```

利用了ethers.js提供的Api轻松完成导入钱包操作。

* 明文私钥导入

![私钥导入](http://p8i3gdhi6.bkt.clouddn.com/ethwallet_privatekey.png)

私钥导入其实只需要一串明文私钥就行了,<span style="color:#FF5151;">因为私钥泄露其实也就是把自己的钱包泄露了</span>,再设置钱包密码就可以导入钱包了。

核心代码如下:

```
  if (this.privateKey.substr(0, 2) !== "0x") {
    this.privateKey = "0x" + this.privateKey;
  }
  try {
    let wallet = new that.ethers.Wallet(this.privateKey);
    console.log("Wallet Address: " + wallet.address);
  } catch (err) {
    console.log(err);
    this.toastText = "明文私钥输入错误";
    this.toast = true;
  }
```

值得一提的是有些应用导出私钥时会把0x去掉,所以我们在导入时记得加回去,可是怎么验证私钥的正确性呢,我用了个hack方法,就是捕获异常。

总结
---
到此已经分享完所有钱包导入方法啦,其中我们还可以加上QRscan扫描识别来导入钱包,其实并不复杂,希望大家看完能略有收获,当然很多不足希望也可以提出,就这样啦~!溜了溜了!

<img src="https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536150274215&di=753c3bfbbb672ee2d3739a1c4c71d1bd&imgtype=0&src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn%2Fw539h421%2F20180129%2F35b0-fyqzcxh8902987.gif" width = "340" height = "200" alt="run"/>