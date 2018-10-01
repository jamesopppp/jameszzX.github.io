title: 忍法丶Css三角形绘画术
cover: http://p8i3gdhi6.bkt.clouddn.com/triangle_2.png
author: 
  nick: James
  link: https://github.com/jameszzX
subtitle: 学习用Css简单粗暴的绘画三角形及气泡需求~!
tags:
     - css
     - html
data: 2018-10-01 08:44:29
categories: "css"
---
前言
===
像我们平常的前端工作中,经常会遇到各种各样的需求,比如有时候需要实现三角形,可能有的童鞋会直接让设计给图实现,但是我们是有追求有逼格的<span style="color:#FF5151;">Geeker</span>(码农),最好实现方法还是使用Css,既环保又安全,下面我们学习下怎么用Css完成一些普遍的三角形需求~

文中demo可以在我的github仓库的[blog Demo](https://github.com/jameszzX/blog-Demo)仓库找到。

#### Border实现三角形的原理

* 首先聊起元素边框,大多数人都觉得边框是矩形的,其实并不是,先看下面这个demo：

<img src="http://p8i3gdhi6.bkt.clouddn.com/triangle2.png" width = "200" alt="triangle2"/>

* 我们只设置了少量的边框宽度及content宽高,注意看边框,是不是还明白跟我们这次的主题有什么关系,心急吃不了热豆腐(滑稽),别急再看下面这个demo:

<img src="http://p8i3gdhi6.bkt.clouddn.com/triangle3.png" width = "160" alt="triangle3"/>

* 这次我们把content的宽高都改成了0,内容没了后,就变成了下面这副模样,看!边框变成了三角形,也就是说在失去content及padding等border内层级宽高后border终于露出了原形,那么我们就可以利用这个来完成我们想要的三角形啦~(机智)

<img src="http://p8i3gdhi6.bkt.clouddn.com/triangle4.png" width = "180" alt="triangle4"/>

* 我们把上右左的边框颜色透明后就得到了一个绿的发光的<span style="color:green;">三角形</span>啦~所以明白了吧!利用border绘画三角形的原理就是这样实现的。

#### 我们再练习下吧

<img src="http://p8i3gdhi6.bkt.clouddn.com/triangle_up.png" width = "120" alt="triangle_up"/>

source code：
```
width: 0;
height: 0;
border-left: 50px solid transparent;
border-right: 50px solid transparent;
border-bottom: 100px solid #469af5;
```

<img src="http://p8i3gdhi6.bkt.clouddn.com/triangle_down.png" width = "120" alt="triangle_down"/>

source code：
```
width: 0;
height: 0;
border-left: 50px solid transparent;
border-right: 50px solid transparent;
border-top: 100px solid #469af5;
```

<img src="http://p8i3gdhi6.bkt.clouddn.com/triangle_left.png?1" width = "120" alt="triangle_left"/>

source code：
```
width: 0;
height: 0;
border-top: 50px solid transparent;
border-right: 100px solid #469af5;
border-bottom: 50px solid transparent;
```

<img src="http://p8i3gdhi6.bkt.clouddn.com/triangle_right.png" width = "120" alt="triangle_right"/>

source code：
```
width: 0;
height: 0;
border-top: 50px solid transparent;
border-left: 100px solid #469af5;
border-bottom: 50px solid transparent;
```

* 上面几个例子理解了其它形状的三角形也就不难完成了（上下左右BABA）,我们聊聊天气泡三角形怎么制作吧~! 上代码~

```
// style
.triangle1 {
    display: inline-block;
    position: relative;
    width: 300px;
    height: 150px;
    border-radius: 20px;
    background-color: #469af5;
    color: #fff;
    text-align: center;
    line-height: 150px;
    font-size: 18px;
    letter-spacing: 0.05em;
}

.triangle1::before {
    position: absolute;
    content: "";
    width: 0;
    height: 0;
    bottom: -30px;
    right: 40px;
    border-width: 30px 30px 0 0;
    border-color: #469af5 transparent transparent transparent;
    border-style: solid;
}

//html
<div class="triangle1">James is a handsome boy.</div>
```

<img src="http://p8i3gdhi6.bkt.clouddn.com/triangle1.png" width = "320" alt="triangle1"/>

这里我们利用了<span style="color:#FF5151;">伪元素</span>来绘画小三角,其实一般运用最多也是利用伪元素来完成一些需求,通过<span style="color:#FF5151;">绝对定位来定位位置</span>,<span style="color:#FF5151;">border-width来控制形状</span>,是不是很简单,多试试就懂啦~!

如果你真的很忙,不想敲代码想快速ctrl+c和ctrl+v实现,[戳这](http://apps.eky.hk/css-triangle-generator/zh-hant)进入生成三角形代码,也是美滋滋的途径哈哈!

总结
---
今天分享的东西就这么简单,Css其实很强大,很多东西效果都可以实现,不要过于依赖图片去完成需求,往后我们再一起学习其他好玩的东西,一起成长一起进步！溜了溜了~

<img src="https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1538306522762&di=1b32cba9cb946169b34f649efe47edc0&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20180628%2Fdf80fe302c2f4e1e9aa4aace3992cdbd.gif" width = "280" alt="run"/>
