---
title: "写给小白的比特币入门"
date: 2020-12-04T21:22:14+08:00
categories: ["btc"]
tags: ["btc"]
featuredImage: ""
featuredImagePreview: ""
draft: false
---

## 说明

为了给小白说清：

私钥 公钥 地址 钱包 交易所 咋获得比特币

简单粗暴，**不讲原理**，**不讲原理**，**不讲原理**

## 定理(雾

说了不讲原理，就当这是定理

`私钥`  →`公钥` → `地址`

按箭头方向，知道前面的，就能计算出后面的，**反过来不行**

因此 `私钥` **最重要！**

他们长啥样：

* `私钥` -  `KwYC54hbaH6X5CrCfDK19oyJd2d1ivnSakbJxrW4ENbi2E2bJkbN`
* `公钥` -  `2f6e7sUQhP6z6mTMhh...(略)...16ME6Y18QSM`
* `地址` -  `16PXzomhwDovGRHaN6WGZXxk5BB1e78dn7`

公钥很长不方便记忆，所以都用地址

## 比特币是如何交易的

一个`地址`相当于一个账户，比特币通过`地址`互相转账

谁都可以向一个`地址`转账，但是要花`地址`里的钱，必须知道`私钥`

这就是为什么`私钥`**最重要**

比特币的区块链上记录的就是`地址`之间的转账记录

有转账记录，就能算出`地址`里有多少钱

## 什么是钱包

一个`地址`就是一个账户，每个人名下都可能有很多账户

但是有一个`地址`就肯定有一个`私钥`

钱包就是帮你管理私钥的

钱包一般都有一下功能：

* 帮你计算你拥有多少钱（就是从区块链上计算地的地址里有多少比特币）

* 备份，如果你手机或电脑丢了，有备份就能找回你的私钥
* 交易，给别的地址转账
* 帮你自动生成私钥（也就是地址）



为什么每个人要有很多地址，而不是一个：

谁都可以从区块链上计算出某个`地址`的交易记录，如果你一直使用一个`地址`，你的隐私可能就暴漏了

一般是不能从`地址`推算出拥有这个`地址`的人是谁的，但如果你用的时间长了，比如从某个网址买东西用这个`地址`转账了，就能吧`地址`和你这个人联系起来，就知道你是谁了

由于`地址`可以凭空产生，谁都可以轻易生成(后面讲)

所以转账都用很多不同地址，不过这些事情钱包帮你做了，小白可能感觉不到



你可能担心钱包安全性，但他们大多是安全的，前提是知名钱包，官网上推荐的钱包一般都安全

[https://bitcoin.org](https://bitcoin.org)

(也可以看我写的另一篇钱包推荐

## 如何生成地址

谁都可以生成一个`私钥`，从而生成`地址`

`私钥`本质上是256个0和1组成的二进制串，然后编码成字符串

这256个0和1是随机的，所以你连续抛256次硬币，就能得到一个地址

这里**随机**非常重要，如果你只是凭喜好写出了256个0和1，那和你有相同习惯的人也可能写出来跟你一样的0和1,等于你的私钥被别人知道了。

没人会去抛硬币吧应该，大家都用软件生成`私钥`，这些软件都有自己的随机方法

这是一个安全的网站：[www.bitaddress.org](https://www.bitaddress.org)

根据你的鼠标位置取样，生成随机的`私钥`



冷钱包：

在离线的安全的环境下生成一个`私钥`，这个`私钥`只有你知道。

如果还能在离线环境签名交易，这个操作就是冷钱包的功能

只要你不联网，就没有泄漏的可能(流氓软件太多)，冷钱包就是一套离线解决方案

当然发布交易还是需要网络，可以把签名后的信息生成二维码，让联网设备读取、发布。

（用市面上常见的钱包已经很安全了



## 交易所

如果你在币圈没有熟人，可以到交易所买比特币

交易所和股票那个交易所的职能差不多

你在上面买的比特币都被存在交易所里，可以提出来，但有手续费

交易所不会吧私钥给你，也就是说你只能通过交易所把比特币提出来，如果交易所跑路了，你币没了(概率极低)

知名交易所都很安全：我一般用火币 ，(火币打钱`1KiritobkMPpaWBjTDHSoiP5icv8PEFNdR`)



交易所注册邀请码：(使用邀请码双方都会获得奖励)

* 火币 -
  * 邀请链接 - [www.huobi.me/topic/invited/?invite_code=6a995](https://www.huobi.me/topic/invited/?invite_code=6a995)
  * 邀请码 - `6a995`
