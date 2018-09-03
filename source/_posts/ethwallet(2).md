title: ETH钱包备份及导入
cover: http://cdn.huodongxing.com/file/20150815/119E53CF55A897EBBFF01476D68A1A31AE/30653022772234638.jpg
author: 
  nick: James
  link: https://github.com/jameszzX
subtitle: 这次我们初探钱包如何备份及导入,当然这还只是简单的尝试,一起加油吧~
tags:
     - eth
     - 区块链
data: 2018-08-10 22:40:05
categories: "eth"
---
前言
===
上次总结了使用助记词创建钱包的摸索笔记,这次说说一个ETH钱包的一些别的功能实现.其实很多事情ethers.js都已经封装好了,我们只要明白流程逻辑再使用就行了,Let's Go!

<img src="https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1531309201614&di=986e2dc27aec0d74e9cc2447da47741c&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20171025%2Fd7507a4209cc4d8383d68e5eca743d2b.gif" width = "400" height = "250" alt="run"/>

### 备份钱包
* 我查看比特币钱包copay的实现是先让用户先验证<span style="color:#FF6666;">口令</span>(前提如果设置了口令的话)：

![copay](http://p8i3gdhi6.bkt.clouddn.com/ethBackup-1.jpg)

* 口令验证成功后,会展示钱包的<span style="color:#FF6666;">助记词</span>,这时会提醒用户需要记下此助记词：

![copay](http://p8i3gdhi6.bkt.clouddn.com/ethBackup-2.jpg)

* 确定记下后,会让你重新输入之前的助记词,顺序都不能乱：

![copay](http://p8i3gdhi6.bkt.clouddn.com/ethBackup-3.jpg)

* 成功输入助记词后,将会提示备份成功：

![copay](http://p8i3gdhi6.bkt.clouddn.com/ethBackup-4.jpg)

>至此就成功备份了钱包,但是,我认为这个备份实际是用户要做的事,没错!就是记下展示的助记词,因为凭借助记词(在没有设置口令的前提)就能直接访问用户的钱包,甚至随便转账操作,当然如果设置了口令的话,2者缺一不可,所以在用户备份前,助记词应该是加密存储下来,等待备份展示,备份成功就销毁了,再也不能在应用里找到此钱包的助记词了.

### 导出钱包
* 验证钱包口令,口令正确才能进入导出功能.

* 导出eth钱包非常简单,其实就是导出一段json格式的代码而已,ethers.js已经封装了一个方法让我们方便快速的调用导出钱包。

```
# 假设钱包已经创建成功,命名wallet

let password = "james";
//设置一个导出传输密码(导入时需要验证)

function callback(percent) {
    console.log("Encrypting: " + parseInt(percent * 100) + "% complete");
}
//定义一个callback函数,接收变量percent为导出百分比.

//为了更直观分开写其实可以与下面合并
let encryptPromise = wallet.encrypt(password, callback);
//使用钱包方法encrypt加密钱包输出json,需传入密码和回调函数,返回加密后的json格式代码.

encryptPromise.then(function(json) {
    console.log(json);
});
//调用promise,成功返回json格式代码
```
* 此时可以选择让用户复制或者保存二维码图片完成导出功能,需要注意的是导出时设置的密码须牢记,因为导入时要用到此密码.

### 导入钱包
* 导入钱包可以使用助记词+口令(如果有的话)导入,或者使用json代码导入,以下是copay的导入功能:

![copay](http://p8i3gdhi6.bkt.clouddn.com/ethBackup5.jpg)

* ETH钱包导入很简单,如果是助记词找回的话,将助记词和口令(如果有)转为种子,再重新生成钱包就是了,代码参考我之前的一篇文章,json代码可以如下
```
* 假设变量data为导出json数据
let json = JSON.stringify(data);
//把复制的json代码转化为JSON格式

let password = "james";
//导出时的传输密码

Wallet.fromEncryptedWallet(json,password).then(function(wallet) {
    console.log("Address: " + wallet.address);
});
//调用eth钱包方法fromEncryptedWallet传入json代码和密码,成功返回钱包
```

总结
---
以上是分享ETH钱包备份及导入的简单实现总结,希望能帮到需要的人呀,当然还有很多不足的地方需要指正,今天到此为止,溜了溜了!~

<img src="https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1531460155157&di=52fa01da43e7f217056cafac530c9389&imgtype=0&src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn%2Fw640h399%2F20180203%2F48bc-fyrcsrx3516446.gif" width = "340" height = "200" alt="run"/>