title: vue-i18n多语言
cover: https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528784675227&di=08badf06aca2ef6ac75d64c29852ae5c&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2Fdcc451da81cb39dbec58249fda160924aa18305a.jpg
author: 
  nick: James
  link: 
subtitle: 最近这段时间因项目需求，需要实现国际化多语言，刚好使用的前端开发框架又是目前大火出自国人尤大神的Vue，所以这篇文章主要抛开原理主要讲述怎么在vue(2.0)上实现多语言切换。
tags:
     - vue
     - javascript
     - vue-plugin
data: 2018-05-09 22:40:05
categories: "vue"
---
## 前言

最近这段时间因项目需求，需要实现国际化多语言，刚好使用的前端开发框架又是目前大火出自国人尤大神的Vue，所以这篇文章主要抛开原理主要讲述怎么在vue(2.0)上实现多语言切换。

### 一、寻找解决方案

由于我主要以vue为技术栈，所以当然寻找基于vue实现的插件，回想起我在浏览一些UI框架的官网时都有看到多语言切换的功能，且在源码里有看到过i18n，没错我们将使用vue-i18n这个国际化插件实现需求(记得随手star哦)：

![i18n](http://p8i3gdhi6.bkt.clouddn.com/vuei18n-1.png)

![i18n2](http://p8i3gdhi6.bkt.clouddn.com/vuei18n-star.png)

Github：[click here ](https://github.com/kazupon/vue-i18n)

<i class="icon-hand-point-left"></i>

Documentation： [click here](https://kazupon.github.io/vue-i18n/en/)

适用<span style="color:#FF5151;"> Vue.js 2.x </span>以上版本

### 二、实践出真理

<img src="https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1526016329035&di=32059ce21b5779a145c8f46b2fb779ce&imgtype=0&src=http%3A%2F%2Fwx4.sinaimg.com%2Forj360%2F915e2ab2gy1fkek4jbsl6j20b40b4gmg.jpg" width = "200" height = "180" alt="pig1"/>

光说有什么用呢，让我们接下来手把手跟着实现吧，let's go!

#### (1). 开发环境

推荐使用<span style="color:#56B277
;"> vue-cli官方脚手架 </span>搭建vue项目，并将项目启动起来：

![vue-cli](http://p8i3gdhi6.bkt.clouddn.com/vuei18n-cli.png)

#### (2). 安装插件

官方文档 Installation：[click here](https://kazupon.github.io/vue-i18n/en/installation.html)

我推荐<span style="color:#FF5151;">npm安装包依赖</span>，至于大家用哪种方式引用还是局部引用可以根据喜好选择：

> $ npm install vue-i18n

#### (3). 实现国际化

在目录下`main.js`文件中配置使用：

1. 引入vue-i18n


    //main.js
    import Vue from 'vue'
    import VueI18n from 'vue-i18n'
        
    Vue.use(VueI18n);

2. 语言资源准备

一般直接使用：

    const i18n = new VueI18n({
      locale: 'zhCHS', // 语言标识
      messages: {
        en: {
          home: {
            hello: 'hello',
            //...
          }
        },
        zhCHS: {
          home: {
            hello: '你好',
            //...
          }
        }
      }
    })
    
但是因为实际项目需要大量语言字段，所以也可以采取引入语言包，这样也比较规范化。

首先新建目录：

![目录](http://p8i3gdhi6.bkt.clouddn.com/vuei18n-pack.png)

新建的语言文件可根据需求增加减少,具体语言文件内容:

    //en.js
    module.exports = {
      home: {
        hello: 'hello'
      }
    }
    //zhCHS.js
    module.exports = {
      home: {
        hello: '你好'
      }
    }

然后在`mian.js`中引入

    import LangEn from './common/lang/en';
    import LangZhCHS from './common/lang/zhCHS';
    
    const i18n = new VueI18n({
      locale: 'zhCHS', // 默认语言标识
      messages: {
        'zhCHS': LangZhCHS, // 简体中文
        'en': LangEn // 英文
      },
    })
    
或用CommonJS模块的require引入也一样，这样同等于import操作。

    const i18n = new VueI18n({
      locale: 'zhCHS', // 语言标识
      messages: {
        'zhCHS': require('./common/lang/zhCHS'), // 简体中文
        'en': require('./common/lang/en') // 英文
      },
    })
    
最后全局挂载使用i18n：

    new Vue({
      el: '#app',
      i18n,  //挂载i18n
      render: h => h(App)
    })
    
<img src="https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1526016933482&di=636d71e67658e0bb826f35d414d701f8&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20180421%2F898cb3b0be0041efaef6eba0ba01b1ce.jpeg" width = "150" height = "140" alt="pig1"/>
至此，已经成功引用i18n了，接下来就直接使用好了。

#### (4).语法使用

> HTML中使用语言标记

    <p>{{ $t("home.hello") }}</p>
    
> Js中使用语言标记

    this.$t("home.hello");
    
> 数据渲染绑定语言标记

    <p v-text="$t('home.hello')"></p>
    
> 还有更多用法，比如与计算属性(computed)配合等：

    computed: {
        sayHello() {
          return this.$t("home.hello") + "," + this.userName;
        }
    }
    
因为我们现在设置的默认语言是"zhCHS"，所以显示的是简体中文语言，如果我们要切换语言环境可以调用i18n全局对象属性直接修改：
    
    this.$i18n.locale = "en";  //切换成英文语言

下面是一个切换语言的小demo：

![toggle](http://p8i3gdhi6.bkt.clouddn.com/toggleLanguage.gif)

以上切换语言按钮操作代码如下：

    toggleLanguage() {
      let locale = this.$i18n.locale;
      locale === "zhCHS"
        ? (this.$i18n.locale = "en")
        : (this.$i18n.locale = "zhCHS");
    }
    
### 三、进阶使用

<img src="https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1526017271395&di=6af5803af56bdf89334baabc95f9cfe0&imgtype=0&src=http%3A%2F%2Fwww.wed114.cn%2Fjiehun%2Fuploads%2Fallimg%2F170613%2F16433115N-4.jpg" width = "150" height = "150" alt="thing"/>

但是事情好像并没这么简单，要是我设置了英文语言，下次打开它又变成了中文不就尴尬了，所以我们可以利用HTML5的localStorage本地存储去实现我们的目的：

    toggleLanguage() {
      let that = this;
      let locale = that.$i18n.locale;
      if (locale === "zhCHS") {
        that.$i18n.locale = "en";
        window.localStorage.setItem("language", "en");   //设置localStorage语言标识
      } else {
        that.$i18n.locale = "zhCHS";
        window.localStorage.setItem("language", "zhCHS");
      }
      console.log(window.localStorage.getItem("language"));
    }
    
首先切换语言处需做出修改，使设置的语言存在本地存储中，神秘代码如上，然后再于`main.js`处做出相应修改:

    //main.js
    function getLanguage() {
      let lang = window.localStorage.getItem('language');  //获取语言标识
      if (lang) {
        return lang; //如果本地已存在设置,就返回该语言
      } else {
        return 'zhCHS'; //没有该标识字段就设置默认语言
      }
    }
    
    const locale = getLanguage();
    
    const i18n = new VueI18n({
      locale: locale, // 获取的语言标识
      messages: {
        'zhCHS': require('./common/lang/zhCHS'), // 简体中文
        'en': require('./common/lang/en') // 英文
      }
    })
    
至此，我们已经实现了切换语言，且下次打开该项目后显示的语言仍就是上一次设置的语言，是不是很简单hhh，虽然很简单，但是原理是这样实现的...

## 总结
这次主要讲的是自己实际工作中遇到多语言切换需求的实现过程，希望能帮到大家，还有很多实现方法，我只是使用了比较简单的一种，也刚好满足我的需求啦，吧啦吧啦谢谢你耐心的看完这篇文章，如果发现不足之处请不要犹豫的说出来，让我们共同进步吧，本人才识疏浅，告辞~

<img src="https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1526017570149&di=0d778cbd177154d73a0e874529d7e4a6&imgtype=0&src=http%3A%2F%2Fimg.mp.itc.cn%2Fupload%2F20161214%2Fe8e7582899384930aa45a2d8542b0df7_th.gif" width = "340" height = "200" alt="run"/>

<div style="margin-top:100px;">

本文由 [James](http://www.jamescathy.top) 创作，采用 [知识共享署名4.0](https://creativecommons.org/licenses/by/4.0/) 国际许可协议进行许可
本站文章除注明转载/出处外，均为本站原创或翻译，转载前请务必署名

<div style="margin-top:50px;">