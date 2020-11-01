---
title: "使用gh-page和CI创建博客"
date: 2020-11-01T14:43:41+08:00
categories: ["default"]
tags: ["blog"]
featuredImage: ""
featuredImagePreview: ""
draft: false
---

## 这个博客是怎么来的
问就是白嫖github page，白嫖太爽了(

静态博客的生成器使用的是[Hugo](https://www.gohugo.org/)。主题使用的[LoveIt](https://hugoloveit.com/zh-cn/theme-documentation-basics/)。评论系统使用[Gitalk](https://github.com/gitalk/gitalk/blob/master/readme-cn.md)，LoveIt这个主题已经集成好了。

由于使用静态博客生成器，在每次改动后都需要重新运行一次生成命令，生成一大堆静态文件，再提交到gh-page,很麻烦。

为了让这个过程更加优雅，可以吧生成静态文件和部署这个过程放到CI里自动化完成。这里使用了github workflow的Action功能。

这样一来，只需要在本地编辑博客内容，然后push到github,就会自动触发CI流程，将生成的静态内容部署到`XXX.github.io`，也就是gh-page的仓库。

## 准备工作
我一共新建了三个仓库：
* `XXX.github.io`， gh-page仓库,由CI负责提交
* `blog`，存放博客文件
* `blog-comment`，存放博客评论

主要工作是在`blog`这个仓库上进行，其余两个仓库都是自动化操作的。

`blog`存放了博客的主要骨架，还有一些脚本，方便在CI中做一些工作

申请一个[Github Application](https://github.com/settings/applications/new)，Gitalk使用它来操作`blog-comment`仓库

申请一个[Personal access tokens](https://github.com/settings/tokens/new)，CI流程中使用它来对`XXX.github.io`仓库进行提交，涉及到鉴权

Github Application 和 Personal access tokens 都是需要保密的，不能直接写在配置文件里或这CI流程的脚本里。好在github的Workflow提供了在CI中访问仓库中配置的秘密环境变量的能力

需要配置，进入仓库->Settings->Secrets->new Secret，配置两个环境变量，如下
![](https://blog-1256556944.cos.ap-nanjing.myqcloud.com/public/github-set-secret.png)


## 杂项

使用了腾讯的[对象存储]( https://console.cloud.tencent.com/cos5/bucket)来存图片，可有可无。

一个域名，可有可无。

阿里云的CDN，可有可无。



## blog搭建过程
首先看下我(本地)仓库的目录情况，[github地址](https://github.com/zshorz/blog)
```sh
.
├── .github
│   └── workflows
│       └── main.yml # github workflow 的action配置文件(CI脚本)
├── .gitmodules # git submodule 创建的，为了引入LoveIt
├── README.md
├── bin # 这个目录是脚本生成的，里面有hugo命令，不会被提交到仓库
├── script
│   └── get-hugo.sh # 本地 CI 都可以执行，用来获取hugo命令
└── site # 站点目录，存放hugo博客的骨架
    ├── archetypes
    ├── config.toml
    ├── config.tomlconfig.toml
    ├── content # 存放博客内容的地方
    ├── data
    ├── layouts
    ├── public # hugo生成的静态博客
    ├── resources
    ├── static # static 目录在生产静态文件时，会被拷贝到public
    │   ├── .nojekyll # 两个文件最终都会出现在gh-page仓库的根目录
    │   └── CNAME # 如过有域名需要这个
    └── themes
        └── LoveIt # submodule方式引入，LoveIt主题
```
`.gitignore`忽略文件
```text
bin/
public/
```

### 骨架
初始化git仓库后，首先编写了[脚本](https://github.com/zshorz/blog/blob/main/script/get-hugo.sh)`script/get-hugo.sh`，这个脚本的功能是自动根据系统类型下载hugo,并解压到脚本所在位置的上级目录下的`bin`文件夹。只支持环境是mac或linux

执行`sh scrpit/get-hugo.sh`，就可以使用hugo了,执行`bin/hugo vesion`打印hugo版本

然后创建站点，执行
```sh
bin/hugo new site .
```
生成site目录
```sh
tree ./site
.
├── archetypes
├── config.toml # 配置文件
├── content
├── data
├── layouts
├── static
└── themes # 主题文件夹
```

拉取主题，我使用的是[LoveIt](https://hugoloveit.com/zh-cn/theme-documentation-basics/)

```sh
# 在site目录执行
git submodule add https://github.com/dillonzq/LoveIt.git themes/LoveIt

# 注意有了submodules后，再从别的地方拉取仓库记得
# git submodule init
# git submodule update
```
参考[LoveIt](https://hugoloveit.com/zh-cn/theme-documentation-basics/)的文档，配置好`config.toml`文件

我的[配置](https://github.com/zshorz/blog/blob/main/site/config.toml),需要说明的只有下面几行
```toml
[params.page.comment.gitalk]
    enable = true
    owner = "zshorz"
    repo = "blog-comment"
    clientId = "04807af2cae459e49713"
    clientSecret = "" # 会在ci中自动填充
```
这是Gitalk的配置，clientId 和 clientSecret 就是准备工作里申请的 Github Application。注意我 clientSecret 留空了，因为是保密的，这个会在CI流程里自动设置

博客编写的部分请直接去看hugo的[文档](https://www.gohugo.org/)

博客有内容后，本地看效果使用
```sh
cd site
# 本地预览（不会展示gitalk）
../bin/hugo server
# 本地预览，但是使用生产环境(会展示gitalk，但不建议)
../bin/hugo server -e production
```

hugo生成静态站点的方式是直接在site目录执行
```sh
../bin/hugo
```
完成后生成`public`文件夹，注意不要提交到仓库中。

把生成的静态站点，提交到gh-page仓库，就能展示博客了。也可以使用其他静态托管服务。

### 配置CI部署
回到仓库根目录，创建Action文件：
```sh
mkdir -p .github/workflows
touch .github/workflows/main.yml
```
我的[CI配置](https://github.com/zshorz/blog/blob/main/.github/workflows/main.yml)，其中需要说明的几行
```yml
- name: init blog
  run: |
    git submodule init 
    git submodule update
    sh script/get-hugo.sh
    cd site
    sed 's/clientSecret/clientSecret = "${{secrets.CLIENT_SECRET}}" #/g' config.toml > config.toml.swa
    cat config.toml.swa > config.toml
    ../bin/hugo

# 部署blog
- name: deploy blog
  env:
    GITHUB_REPO: github.com/zshorz/zshorz.github.io
  run: |
    cd site/public
    git init && git add .
    git config user.name "zshorz"
    git config user.email "1026860069@qq.com"
    git commit -m "GitHub Actions Auto Builder at $(date +'%Y-%m-%d %H:%M:%S')"
    git push --force --quiet "https://${{ secrets.ACCESS_TOKEN }}@$GITHUB_REPO" master:master
```

还记得在仓库中配置了secret环境变量，而在CI中访问那些环境变量的方法就是`${{secrets.NAME}}`

CI的脚本有两部分，首先初始化blog，然后将生成的静态网站，部署到`xxx.github.io`

我把脚本抽出来单独注释（注意这是在CI的docker自动执行的，不是本地环境）

第一部分
```sh
# 初始化submodule，拉取LoveIt主题
git submodule init 
git submodule update
# 执行脚本安装hugo环境
sh script/get-hugo.sh
cd site
# 配置gitalk的clientSecret，用sed直接替换配置文件文本
sed 's/clientSecret/clientSecret = "${{secrets.CLIENT_SECRET}}" #/g' config.toml > config.toml.swa
cat config.toml.swa > config.toml
# 生成站点，输出到public目录
../bin/hugo
```
第二部分
```sh
# 进入生成的静态站点目录
cd site/public
# 初始化为git仓库
git init && git add .
git config user.name "zshorz"
git config user.email "1026860069@qq.com"
# 本地提交
git commit -m "GitHub Actions Auto Builder at $(date +'%Y-%m-%d %H:%M:%S')"
# 强制推送到远端仓库 github.com/zshorz/zshorz.github.io
git push --force --quiet "https://${{ secrets.ACCESS_TOKEN }}@$GITHUB_REPO" master:master
```
到此CI就配置好了

### push仓库
直接将你的仓库push到远端，会自动触发CI，你可以在这里查看执行情况
![](https://blog-1256556944.cos.ap-nanjing.myqcloud.com/public/github-ci.png)

待CI执行成功后，打开在浏览器中输入`xxx.github.io`查看博客站点，就是你现在看到的样子了

## 可选项目
### 配置域名
比如域名是`shorz.cn`，你想当你访问`www.shorz.cn`的时候，就是你的博客站点。

添加文件`site/static/CNAME`，在里面写上`www.shorz.cn`，push让CI再次构建

然后打开你的域名控制台，为`www.shorz.cn`添加一个CNAME记录，记录值为`xxx.github.io`

稍后浏览器输入域名网址，你就又看到这个页面了
### CDN加速
我用的阿里云的cdn，不知道为啥还没收我钱(

## 最后
git push 享受下 CI 部署的丝滑(