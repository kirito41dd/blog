---
title: "RSA算法原理"
date: 2021-01-31T13:56:06+08:00
categories: ["default"]
tags: ["RSA"]
featuredImage: ""
featuredImagePreview: ""
draft: false
---

# RSA 算法原理

## 数论知识

**质数**

​	大于1的自然数中，只能被1和它本身的数整除，如 2、3、5、7

**互质关系**：

​	如果两个正整数，除了1以外，没有其他公因子，我们就称这两个数是互质关系

* 1与任何数都互质
* 任意两个质数都互质
* 质数与小于它的每一个数，都构成互质关系。如5与1、2、3、4都构成互质关系

**欧拉函数**：

​	任意给定正整数n，请问在小于等于n的正整数之中，有多少个与n构成互质关系？计算这个值的方法就叫做欧拉函数，以符号$\phi(n)$表示

* $\phi(1)=1$
* 如果n为质数，则 $\phi(n)=n-1$
* 如果n是两个互质的整数之积 $n=p_1\times p_2$ 则 $\phi(n)=\phi(p_1)\times \phi(p_2)$

**欧拉定理**：

​	如果两个正整数a和n互质，则下面的公式成立：
$$
a^{\phi(n)} \equiv 1 \pmod n
$$
**模反元素**：

​	如果两个正整数a和n互质，那么一定可以找到b，使得下面的公式成立：
$$
ab\equiv1\pmod n
$$
​	证明模反元素必然存在，把欧拉定理拆开，$a\times a^{\phi(n)-1} \equiv 1 \pmod n$,  

$a^{\phi(n)-1} + kn$ 全都是模反元素

## 密钥生成步骤

**随机选择两个不相等的质数p和q (越大越好)**

**计算p和q的乘积** $n=p\times q$ 

**计算n的欧拉函数** $\phi(n)=(p-1)(q-1)$

**随机选择一个整数e**, $1<e<\phi(n) 且 e与\phi(n)互质$

**计算e对于$\phi(n)$的模反元素d**（知道e和$\phi(n)$就等于知道了模反元素）



**公布(n,e)为公钥、(n,d)为私钥**

## 加密和解密

**加密**：公钥(n,e)

加密信息为m, m必须是整数，且m必须小于n

加密就是算出下面式子中的c:
$$
m^e\equiv c \pmod n
$$
即密文 $c=m^e\bmod n$

**解密**： 私钥(n,d)

下面的等式一定成立:
$$
c^d \equiv m \pmod n
$$
即明文 $m = c^d\bmod n$



## 证明
<div>
$$
为什么\ \ c^d \equiv m \pmod n \ \ \ (1) \\ 
\because m^e\equiv c \pmod n\\
\therefore c = m^e-kn\\
c带入(1)得 \ (m^e - kn)^d \equiv m \pmod n\\
等同与\ m^{ed}\equiv m \pmod n \ \ (2)\\
(比如(a+b)^2 = a^2 + 2ab + b2，只有a得最高项不带b) \\
\because ed \equiv 1 \pmod{\phi(n)}\\
\therefore ed = h\phi(n) +1 \\
将ed带入(2)得 \ m^{h\phi(n)+1} \equiv m \pmod n \ \ \ (3)\\
$$
</div>
证明(1)就是证明（3）：

如果 m 和 n 互质

<div>
$$
由欧拉定理得\ m^{\phi(n)}\equiv 1 \pmod n \ \\
\because m\equiv m \pmod n \\
同余式相乘性质：若a≡b(mod\ n)，c≡d(mod\ n)，则ac≡bd(mod\ n)。\\
(m^{\phi(n)})^h\times m \equiv m \times1^h \pmod n \\
m^{h\phi(n)+1} \equiv m \pmod n\\
证明完成
$$
</div>

如果 m 和 n 不互质

<div>
$$
\because n = pq\ (质因子)\\\therefore 必然有\ m = kp\ 或\ m=kq\ (公因子只能是p或q)\\以\ m=kp\ 为例，kp必然互质,p为质数\\根据欧拉定理\ (kp)^{q-1} \equiv 1 \pmod q \ (自己乘上自己，再两边同时乘kp)\\进一步得到\ [(kp)^{q-1}]^{h(p-1)} \times kp \equiv kp \pmod q\\\therefore ed = h\phi(n) +1 \\化简\ (kp)^{ed} \equiv kp \pmod q\\改写成\ (kp)^{ed} = kp + tq\\这时t必然能被p整除,即\ t=t'p\ (因为(kp)^{ed}一定是p的整倍数)\\(kp)^{ed} = kp+t'pq\\\because m=kp, n=pq\\\therefore m^{ed}=m+t'n\\\therefore m^{ed} \equiv m \pmod n\\证明完成
$$
</div>
