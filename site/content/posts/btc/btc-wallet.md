---
title: "比特币钱包推荐"
date: 2021-01-05T20:50:00+08:00
categories: ["btc"]
tags: ["btc"]
featuredImage: ""
featuredImagePreview: ""
draft: false
---
## 说明

推荐下我使用过的钱包，来给你提供建议。

## Bitcoin Core

[![](https://blog-1256556944.cos.ap-nanjing.myqcloud.com/public/bitcoincore.png)]()

关键信息：
* 平台：Windows、Linux、MacOS
* 获取：[https://bitcoin.org/zh_CN/download](https://bitcoin.org/zh_CN/download)
* 源代码：[https://github.com/bitcoin/bitcoin](https://github.com/bitcoin/bitcoin)
* 全节点：是

核心钱包是全节点钱包，意味着你需要同步并存储所有区块数据。截止到2021年，区块数据约350GB，你至少需要保证500GB的存储空间以应对未来的数据增长。虽然全节点能够使区块链更安全，但不建议小白同步。因为如果你的全节点不能以服务的形式存在（通常需要一个公网IP），那么别人并不能主动和你建立链接，意义不大。提供全节点服务以保障区块链安全的使命请交给其他有情怀的专业人士。对于非专业人士（特指不是程序员）操作过于繁琐，不建议使用。

[![](https://blog-1256556944.cos.ap-nanjing.myqcloud.com/public/bitcoincore-ui.png)]()


优点：
* 开源，意味着更安全，开发者不受任何人控制。
* 支持HD钱包: bip32「分层确定性(Hierarchical Deterministic)钱包」
* 有强大的命令行，不过需要大量学习

缺点：
* 新版本不支持生成1开头的地址（我平时不用的理由
* 要时常备份钱包文件（找零机制，外部导入私钥 这些都需要备份才行）
* 学习成本高


## Electrum
[![](https://blog-1256556944.cos.ap-nanjing.myqcloud.com/public/electrum.png)]()

关键信息：
* 平台：Windows、Linux、MacOS、Android（超难看）
* 获取：[https://electrum.org](https://electrum.org)
* 源代码：[https://github.com/spesmilo/electrum](https://github.com/spesmilo/electrum)
* 全节点：否

Electrum是一个轻节点钱包，你不用同步节点数据，而是由别人提供的服务器来帮你广播、查询交易。这些服务器不会存储你的私钥（也做不到）。你只需要连接一些服务器，就能够安全的完成交易。

[![](https://blog-1256556944.cos.ap-nanjing.myqcloud.com/public/electrum-ui.png)]()

优点：
* 使用方便
* 支持HD钱包，支持助记词（但不是bip39）
* 功能强大，兼容所有地址类型

缺点：
* 不支持导出bip39助记词，使用的是自定义版本，但可以导入bip39
* 只能使用桌面版本，移动端不支持（Android版本做的太垃圾了
* 除了上面，我觉得完美


## Imtoken
[![](https://blog-1256556944.cos.ap-nanjing.myqcloud.com/public/imtoken.svg)]()

关键信息：
* 平台：Android、iOS
* 获取：谷歌商店、App Store、[https://token.im](https://token.im/?locale=zh)
* 部分源代码：[https://github.com/consenlabs/token-core](https://github.com/consenlabs/token-core)
* 全节点：否

Imtoken是一个主打移动端的轻节点钱包，并且支持多币种，能满足日常使用。

<img src="https://blog-1256556944.cos.ap-nanjing.myqcloud.com/public/imtoken-ui.jpg" width = "200" height = "400" />


优点：
* HD钱包，支持导出bip39助记词
* 同时支持隔离见证地址和普通地址
* 对地址私钥控制方便，可以任意导出

缺点：
* 多币种钱包（我只需要btc
* 有官方的一些推送内容
* 夹私货，推销自己的平台币（无奈其他开源移动端功能不够，我目前使用这个

## 其他
这个网站列出了可信度较高的钱包：[https://bitcoin.org](https://bitcoin.org/zh_CN/choose-your-wallet?step=5)

桌面端基本用core钱包或Electrum就够了。

移动端我也用Bither，觉得很不错，比imtoken功能少点，但完全开源更可信。

其他交易所推出的钱包我就不推荐了，夹私货太多。


## 推荐阅读

* [bip32、bip39、bip44](https://learnblockchain.cn/2018/09/28/hdwallet)