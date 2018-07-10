title: window下运行比特币钱包copay
cover: https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=51941477,2466741739&fm=15&gp=0.jpg
author: 
  nick: James
  link: https://github.com/jameszzX
subtitle: window下运行copay的一些爬坑总结
tags:
     - btc
     - copay
data: 2018-07-10 21:30:05
categories: "copay"
---
## 前言
window环境下跑copay有很多坑,记录下成功跑起来的过程,真是一把心酸一把泪~

<img src="https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1525862111333&di=f79ee5b566b2e2049bc645ca7e6bf394&imgtype=0&src=http%3A%2F%2Fimg2.jiemian.com%2F101%2Foriginal%2F20170930%2F150676527189819600_a580xH.jpg" width = "200" height = "200" alt="pig1"/>

#### 一、执行环境
当前系统的环境部署如下

```
node v8.9.3
npm v6.1.0
cordova v8.0.0
cnpm v5.6.0
```

#### 二、克隆仓库 
克隆项目至本地

`git clone https://github.com/bitpay/copay `

#### 三、修改依赖
修改根目录package.json下的开发依赖(devDependencies)至对应版本号:

```
    "@biesbjerg/ngx-translate-extract": "2.3.4",
    
    "@ionic-native-mocks/android-fingerprint-auth": "2.0.6",
    
    "@ionic-native-mocks/fcm": "2.0.6",
```

因为某些版本无法安装上.

#### 四、手动安装以下依赖包
此处强烈建议使用cnpm,因为使用npm会出现莫名其妙的错误,cnpm大法好!
```
cnpm i @ionic/app-scripts ionic-angular @ionic-native/core  //ionic核心
cnpm i node-sass   // sass要用的
cnpm i secp256k1@3.5.0  //椭圆计算
```
以上命令都正确安装后,再执行
```
cnpm i
安装依赖
```

然后运行以下命令,注意第二个命令需要运行在项目Git Bash命令行内才能生效.
```
npm run apply:copy
npm run env:dev  //gitbash
```
最后
```
npm run start
启动项目
```

#### 五、处理报错

然后会报许多typescript的错误,大部分都是spec.ts文件,貌似都是自动化单元测试用的文件,所以项目下全局搜索spec.ts文件并删除,这个时候只剩下少量错误了,注释掉就可以再运行启动项目啦。

![copay](http://p8i3gdhi6.bkt.clouddn.com/copay-ok.png)

总结
---
因为copay的开发团队是在mac下开发的,所以难免跑在window上会出现很多奇怪的问题,只能说很多坑要自己爬了才知道吧...

<img src="https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1531225707084&di=de973c6dd025537192703d2629f5da34&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20171113%2F7e8f2c8766604e2e871d1ae7969f24d2.gif" width = "340" height = "200" alt="run"/>