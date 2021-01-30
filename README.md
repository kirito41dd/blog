# hugo-env
a blog env

```sh
git submodule init
git submodule update
```

## hugo常用命令
```sh
# 在当前目录创建站点
hugo new site .
# 创建一篇文章
hugo new posts/test.md
# 本地预览
hugo server
# 本地预览，但是使用生产环境
hugo server -e production
```

## hugo站点目录树
```sh
tree
.
├── archetypes
├── config.toml # 配置文件
├── content # 存储文章
├── data
├── layouts
├── static # 静态文件，会被复制到自动生成目录
└── themes # 主题文件夹
```
